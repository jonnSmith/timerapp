<?php

namespace App;

use Illuminate\Foundation\Auth\User as Authenticatable;
use Carbon\Carbon;
use Hash;
use App\Http\Requests\Request;
use JWTAuth;

class User extends Authenticatable
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name', 'email', 'password','group_id','is_super_admin'
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */


    protected $hidden = [
        'password', 'remember_token',
    ];

    protected $appends = ['time_is_open', 'time_open', 'time_last_closed', 'is_moderator','my_groups'];


    public function times()
    {
        return $this->hasMany('App\Time');
    }

    public function group()
    {
        return $this->belongsTo('App\Group');
    }


    public function scopeWithPermissions($query, $id=null)
    {

        if (!$user = JWTAuth::toUser())
            return $query->whereId(0);


        if ($id)
            $query->whereId($id);

        if ($user->is_super_admin)
            return $query->with('times');

        if (!$user->group_id)
            return $query->whereId($user->id);

        if ($user->is_moderator)
            return $query->where('group_id',$user->group_id);
        $query->where('group_id',$user->group_id);


        if ($id)
            return $query->whereId($user->id)->with('times');
        return $query;
    }




    public function toStartTime($param = array())
    {

        if (!$this->times()->create([
            'start' => Carbon::now(),
            'start_location' => (isset($param['location'])) ? $param['location'] : 0,
            'start_ip' => $param['ip'],
            'comment' => (isset($param['comment'])) ? $param['comment'] : null,
        ]))
            return false;
        return true;

    }

    public function toEndTime($param = array())
    {
        $time = $this->getLastTime();

        if ($time->isClosed)
            return false;

        $time->end = Carbon::now();
        $time->end_location = (isset($param['location'])) ? $param['location'] : 0;
        $time->end_ip = $param['ip'];
        if (!empty($param['comment']))
            $time->comment = $param['comment'];

        return $time->save();

    }

    public function toStrikeTime($value = null)
    {
        $time = $this->getLastTime();

        if ($time->isClosed)
            return false;

        $time->is_strike = (isset($value)) ? ($value) : 1;

        return $time->save();

    }

    public function getLastTime(){
        if (!$timer = $this->times()->getLast())
            return false;
        return $timer;
    }

    public function getOpenTime(){
        if (!$timer = $this->times()->getOpen())
            return false;
        return $timer;
    }

    public function getLastClosed(){
        if (!$timer = $this->times()->GetLastClosed())
            return false;
        return $timer;
    }



    public function getTimeLastClosedAttribute(){
        return  $this->getLastClosed();
    }

    public function getTimeOpenAttribute(){
        return  $this->getOpenTime();
    }

    public function getTimeIsOpenAttribute(){
        if (isset($this->getOpenTime()->id))
            return true;
        return false;
    }

    public function getIsModeratorAttribute(){
        if (!empty($this->group->moderator_id))
            if ($this->group->moderator_id == $this->id)
                return  true;
            return false;
    }

    public function getMyGroupsAttribute(){
        if ($this->is_moderator)
            return $this->group;
    }


    public function setPasswordAttribute($pass){

        $this->attributes['password'] = Hash::make($pass);

    }

    public function hasPermissionAll($id=null)
    {
        if (!$user = JWTAuth::toUser())
            return false;
        if ($user->is_super_admin)
            return true;
        if ($user->id == $id)
            return true;
        if (($user->is_moderator)and($user->group->users()->whereId($id)->get()))
            return true;

        return false;
    }

    public function hasPermissionGroups($id=null)
    {
        if (!$user = JWTAuth::toUser())
            return false;
        if ($user->is_super_admin)
            return true;
        if (($user->is_moderator)and($this->group_id == $id))
            return true;

        return false;
    }
}

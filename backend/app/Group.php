<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use JWTAuth;


class Group extends Model
{
    protected $fillable = [
        'title', 'description', 'moderator_id'
    ];


    public function moderator()
    {
        return $this->belongsTo('App\User');
    }

    public function users()
    {
        return $this->hasMany('App\User');
    }



    public function scopeWithPermissions($query,$id=null)
    {

        if (!$user = JWTAuth::toUser())
            return $query->whereId(0);

        $query->with('users')->with('moderator');
        if ($id)
            $query->whereId($id);

        if ($user->is_super_admin)
            return $query;
        if (($user->is_moderator))
            return $query->where('id', $user->group->id);
        return $query->whereId(0);
    }
}

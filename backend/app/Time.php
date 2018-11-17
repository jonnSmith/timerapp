<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class Time extends Model
{

    protected $table = 'times';

    protected $fillable = [
        'start', 'end', 'is_strike', 'start_location', 'end_location', 'start_ip', 'end_ip', 'comment'
    ];

    protected $appends = ['is_open', 'is_closed'];

    public function user()
    {
        return $this->belongsTo('App\User');
    }

    public function scopeGetLast($query)
    {
        return $query->orderBy('id', 'desc')->first();
    }

    public function scopeGetOpen($query)
    {
        return $query->whereNull('end')->GetLast();
    }

    public function scopeGetLastClosed($query)
    {
        return $query->where('end','>',1)->GetLast();
    }

    public function scopeoffset($query, $data = array())
    {
        $period = false;
        $offset = 0;
        $count = 1;
        $order = 'desc';
        extract($data);
        if ($period){
            $date_from = Carbon::today();
            $date_till = Carbon::today();
            if ($count > 0) $count--;
            if ($period =='day'){
                $date_from->subDays($offset+$count+1);
                $date_till->subDays($offset);
            }
            elseif ($period =='week'){
                $date_from->subWeeks($offset+$count+1);
                $date_till->subWeeks($offset);
                //dd($date_from->toDateString(), $date_till->toDateString());
            }
            elseif ($period =='month'){
                $date_from->subMonths($offset+$count+1);
                $date_till->subMonths($offset);
            }

            $query->whereDate('created_at', '>', $date_from->toDateString())
                  ->whereDate('created_at', '<=', $date_till->toDateString());
        }

        if ($order=="asc")
            $query->orderAsc();
        elseif ($order=="desc")
            $query->orderDesc();



        return $query;
    }

    public function scopeOrderAsc($query)
    {
        return $query->orderBy('id', 'asc');
    }

    public function scopeOrderDesc($query)
    {
        return $query->orderBy('id', 'desc');
    }




    public function getIsClosedAttribute()
    {
        if ($this->end > 0)
            return true;
        else
            return false;
    }

    public function getIsOpenAttribute()
    {
        if ($this->start > 0)
            return true;
        else
            return false;
    }

}

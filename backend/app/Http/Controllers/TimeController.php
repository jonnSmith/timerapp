<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\User;
use App\Time;
use JWTAuth;

class TimeController extends Controller
{
    protected $user;

    protected $success_message = ['status'=>"success"];
    protected $error_message =   ['error'=>"Something going wrong"];

    public function __construct()
    {
        $this->user = JWTAuth::toUser();
    }


    public function index()
    {
        $times = Time::all();
        //dd($times);
        return $times;
    }

    public function start(Request $request, $id = null)
    {
        $user = $this->user;
        if ($id)
            if (empty($user = $this->getUser($id)))
                return $this->error_message('User Doesnt exist');

        $data =  $request->all();
        $data['ip'] = $request->ip();

        if ($user->time_is_open)
                return $this->error_message('Timer is already starting');

        if (!$user->toStartTime($data))
            return $this->error_message;

        return $this->success_message;
    }

    public function end(Request $request, $id = null)
    {
        $user = $this->user;
        if ($id)
            if (empty($user = $this->getUser($id)))
                return $this->error_message('User Doesnt exist');

        $data = $request->all();
        $data['ip'] = $request->ip();

        if ($user->getLastTime()->isClosed)
            return $this->error_message('Timer is already closed');

        if (!$user->toEndTime($data))
            return $this->error_message;

        return $this->success_message;
    }

    public function strike(Request $request, $id = null)
    {
        $user = $this->user;
        $value = $request->input('value');

        if ($id)
            if (empty($user = $this->getUser($id)))
                return $this->error_message('User Doesnt exist');

        if ($user->getLastTime()->isClosed)
            return $this->error_message('Timer is already closed');

        if (!$user->toStrikeTime($value))
            return $this->error_message;

        return $this->success_message;
    }


    protected function error_message($custom_message = null)
    {
        if ($custom_message)
            return response()->json(['error'=>$custom_message]);

        return response()->json($this->success_message);
    }

    protected function success_message($custom_message = null)
    {
        if ($custom_message)
            return response()->json(['status'=>$custom_message]);

        return response()->json($this->error_message);
    }


    protected function getUser($id)
    {
        if (!empty($user = User::WithPermissions($id)->get()->first()))
            return $user;
        else
            return false;
    }
}

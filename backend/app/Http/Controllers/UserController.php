<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Requests;
use App\Http\Controllers\Controller;
use JWTAuth;
use Tymon\JWTAuth\Exceptions\JWTException;
use App\User;
use Validator;
use Mail;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    protected $success_message = ['status'=>"success"];
    protected $error_message =   ['error'=>"Something going wrong"];


    public function index()
    {
        $users = User::WithPermissions()->get();
        return response()->json($users)->setEncodingOptions(JSON_NUMERIC_CHECK);
    }

   /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response*/

    public function create(Request $request)
    {
        $data = $request->all();

        $validation = $this->validator($data);

        if ($validation->fails()) {
            return response()->json(array('error'=>$validation->errors()));
        }

        $user = User::create($data);
        //Mail::pretend();
        /*Mail::send(
            'email.registration',
            [
                'login'=>$user->email,
                'password'=>$data['password']
            ],
            function($u) use ($user)
            {
                $u->from('admin@timer.com');
                $u->to($user->email);
                $u->subject('Данные регистрации');
            }
        );*/

        return $user;


    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    /*public function store(Request $request)
    {

    }*/

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {

        if ($user = $this->getUser($id))
            return response()->json($user)->setEncodingOptions(JSON_NUMERIC_CHECK);
        else
            return $this->error_message("User doesn't exist");
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response

    public function edit($id)
    {
        //
    }*/

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        if (!$user = $this->getUser($id))
            return $this->error_message("User doesn't exist");

        $data = $request->all();

        $validation = Validator::make($data, [
            'name' => 'max:255',
            'email' => 'email|max:255|unique:users,email,'.$user->id,
            'password' => 'min:4',
            'group_id' => 'integer',
        ]);

        if ($validation->fails()) {
            return response()->json(array('error'=>$validation->errors()));
        }

        $user->update($data);

        $user->save();

        return $user;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        if (!$user = $this->getUser($id))
            return $this->error_message("User doesn't exist");

        if (!$user->hasPermissionAll($id))
            return $this->error_message("You don't have such perrmission");

        if (!$user->delete())
            return $this->error_message('Deleting going wrong');

        return $this->success_message();

    }


    public function times(Request $request,$id)
    {

        if (!$user = $this->getUser($id))
            return $this->error_message("User doesn't exist");

        if (!$user->hasPermissionAll($id))
            return $this->error_message("You don't have such perrmission");

        $times = $user->times();

        $period = ($request->get('period')) ? $request->get('period') : null;
        $count = ($request->get('count')) ? $request->get('count') : null;
        $offset = ($request->get('offset')) ? $request->get('offset') : 0;
        $order  = ($request->get('order')) ? $request->get('order') : null;

        $data = [
            'period' => $period,
            'offset' => $offset,
            'count' => $count,
            'order' => $order,
            ];

        $times->offset($data);

        return response()->json($times->get())->setEncodingOptions(JSON_NUMERIC_CHECK);
    }



    protected function error_message($custom_message = null)
    {
        if ($custom_message)
            return response()->json(['error'=>$custom_message]);

        return response()->json($this->error_message);
    }

    protected function success_message($custom_message = null)
    {
        if ($custom_message)
            return response()->json(['status'=>$custom_message]);

        return response()->json($this->success_message);
    }


    /**
     * Get a validator for an incoming registration request.
     *
     * @param  array  $data
     * @return \Illuminate\Contracts\Validation\Validator
     */
    protected function validator(array $data)
    {
        return Validator::make($data, [
            'name' => 'required|max:255',
            'email' => 'required|email|max:255|unique:users',
            'password' => 'required|min:4',
        ]);
    }

    protected function getUser($id)
    {
        if (!empty($user = User::WithPermissions($id)->get()->first()))
            return $user;
        else
            return false;
    }

}

<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\Group;
use App\User;
use JWTAuth;
use Validator;

class UserGroupController extends Controller
{
    protected $user;
    protected $success_message = ['status'=>"success"];
    protected $error_message =   ['error'=>"Something going wrong"];

    public function __construct()
    {
        $this->user = JWTAuth::toUser();
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $userGroups = Group::WithPermissions()->get();
        //->where('moderator_id',$this->user->id);
        return response()->json($userGroups)->setEncodingOptions(JSON_NUMERIC_CHECK);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(Request $request)
    {
        $data = $request->all();

        $validation = Validator::make($data, [
            'title' => 'required|max:255',
            'description' => '',
            'moderator_id' => 'integer',
        ]);

        if ($validation->fails()) {
            return response()->json(array('error'=>$validation->errors()));
        }

        $userGroup = Group::create($data);

        return $userGroup;
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        if ($userGroup = $this->getGroup($id))
            return response()->json($userGroup)->setEncodingOptions(JSON_NUMERIC_CHECK);
        else
            return $this->error_message("User Group doesn't exist");
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {

    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $userGroup = $this->getGroup($id);
        $data = $request->all();

        $validation = Validator::make($data, [
            'title' => 'max:255',
            'description' => '',
            'moderator_id' => 'integer',
        ]);

        if ($validation->fails()) {
            return response()->json(array('error'=>$validation->errors()));
        }

        $userGroup->update($data);
        $userGroup->save();

        return $this->success_message();
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        if (!$user = $this->getGroup($id))
            return $this->error_message("User Group doesn't exist");

        if (!$user->delete())
            return $this->error_message('Deleting going wrong');

        return $this->success_message();
    }


    public function adduser($id, $user_id)
    {
        if (!$userGroup = $this->getGroup($id))
            return $this->error_message("User Group doesn't exist");

        if (empty($user = User::whereId($user_id)->get()->first()))
            return $this->error_message("User doesn't exist");

        $user->group_id = $userGroup->id;

        if ($user->save())
            return $this->success_message();
    }

    public function removeuser($id, $user_id)
    {
        if (!$userGroup = $this->getGroup($id))
            return $this->error_message("User Group doesn't exist");

        if (empty($user = User::whereId($user_id)->get()->first()))
            return $this->error_message("User doesn't exist");

        $user->group_id = null;
        if ($user->save())
            return $this->success_message();
    }

    public function setmoderator($id, $user_id)
    {
        if (!$userGroup = $this->getGroup($id))
            return $this->error_message("User Group doesn't exist");

        if (empty($user = User::whereId($user_id)->get()->first()))
            return $this->error_message("User doesn't exist");

        $userGroup->moderator_id = $user->id;
        if ($userGroup->save())
            return $this->success_message();
    }









    protected function getGroup($id)
    {
        //where('moderator_id',$this->user->id)
        if (!empty($userGroup = Group::WithPermissions($id)->get()->first()))
            return $userGroup;
        else
            return false;
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
}

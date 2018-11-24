<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class ExtendTimesTableIp extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('times', function (Blueprint $t) {
            $t->string('start_ip', 264);
            $t->string('end_ip', 264);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('times', function($t) {
            $t->dropColumn('start_ip');
            $t->dropColumn('end_ip');
        });
    }
}

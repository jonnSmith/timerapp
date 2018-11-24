<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class ExtendTimesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('times', function(Blueprint $t) {
            $t->string('start_location', 264);
            $t->string('end_location', 264);
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
            $t->dropColumn('start_location');
            $t->dropColumn('end_location');
        });
    }
}

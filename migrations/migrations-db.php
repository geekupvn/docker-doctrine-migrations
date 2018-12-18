<?php
return [
    'driver'        => 'pdo_pgsql',
    'host' 			=> 'postgres',
    'user' 		    => 'postgres',
    'password' 		=> 'postgres',
    'dbname' 		=> 'doctrine',
    'charset'       => 'utf8',
    'mapping_types' => [
        'enum' => 'string'
    ]
];
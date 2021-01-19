<?php
return [
    'settings' => [
        'displayErrorDetails' => true, // set to false in production
        'addContentLengthHeader' => false, // Allow the web server to send the content-length header

        // Renderer settings
        'renderer' => [
            'template_path' => __DIR__ . '/../templates/',
        ],

        // Monolog settings
        'logger' => [
            'name' => 'slim-app',
            'path' => isset($_ENV['docker']) ? 'php://stdout' : __DIR__ . '/../logs/app.log',
            'level' => \Monolog\Logger::DEBUG,
        ],
        'db' => [
            'host' => '127.0.0.1',
            'user' => 'root',
            'pass' => '123456',
            'dbname' => 'test',
            'driver' => 'mysql'
        ]
    ],
];
/*
CREATE TABLE books (
    book_id INT NOT NULL AUTO_INCREMENT, 
    title VARCHAR(255) NOT NULL, 
    author VARCHAR(255) NOT NULL, 
    sinopsis TEXT NOT NULL, 
    cover VARCHAR(255) NOT NULL DEFAULT 'default_cover.png', 
    PRIMARY KEY (`book_id`)
) ;
INSERT INTO `books` (`book_id`, `title`, `author`, `sinopsis`, `cover`) VALUES (NULL, 'Judul Buku', 'pengarang', 'sinopsisnya','default_cover.png');
https://www.petanikode.com/slim-api/
*/

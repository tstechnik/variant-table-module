<?php
/**
 * @TODO LICENCE HERE
 */

/**
 * Metadata version
 */
$sMetadataVersion = '2.0';

/**
 * Module information
 */
$aModule = array(
    'id'          => 'tstechnikVariantTableModule',
    'title'       => array(
        'de' => 'OXID6 Varianten Tabelle module',
        'en' => 'OXID6 Variant Table module',
    ),
    'description' => array(
        'de' => '<h2>OXID6 Varianten Tabelle module</h2>',
        'en' => '<h2>OXID6 Varianten Tabelle module</h2>',
    ),
    'version'     => '1.0.0',
    'author'      => 'Ümit Sevim - Artan-Design Webentwicklung',
    'url'         => 'https://www.artan-design.de',
    'email'       => 'info@artan-design.de',
    'extend'      => array(
        \OxidEsales\Eshop\Application\Model\Article::class => \tstechnik\VariantTableModule\Model\TstechnikVariantArticle::class,
    ),
    'controllers'       => array(),
    'files'       => array(),
    'templates'   => array(),
    'blocks'      => array(
        array(
            'template' => 'page/details/inc/tabs.tpl',
            'block' => 'details_tabs_main',
            'file'=> '/views/tpl/tabelle.tpl'
        ),
    ),
    'settings'    => array(),
    'events'      => array(),
);

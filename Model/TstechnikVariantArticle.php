<?php

namespace tstechnik\VariantTableModule\Model;

class TstechnikVariantArticle extends TstechnikVariantArticle_parent {

    protected $_oAttributeList = null;

    public function getAttributes()
    {
        if ($this->_oAttributeList === null) {
            // all attributes this article has
            $this->_oAttributeList = oxNew(\OxidEsales\Eshop\Application\Model\AttributeList::class);
            $this->_oAttributeList->loadAttributes($this->getId(), $this->getParentId());
        }

        return $this->_oAttributeList;
    }
}
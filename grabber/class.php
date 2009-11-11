<?php

/**

 * XML-������, ������ ��� SimpleXML

 */

class XML implements ArrayAccess, IteratorAggregate, Countable {

      /**

       * ��������� �� ������� �������

       * @var XML

       */

      private $pointer;

      /**

       * �������� ��������

       * @var string

       */

      private $tagName;

      /**

       * ������������� ������ ���������

       * @var array

       */

      private $attributes = array();

      /**

       * ���������� ��������

       * @var string

       */

      private $cdata;

      /**

       * ��������� �� ������������ �������

       * @var XML

       */   

      private $parent;

      /**

       * ������ ��������, ����:

       * array('tag1' => array(0 =>, 1 => ...) ...)

       * @var array

       */

      private $childs = array();

         

      /**

       * ����������� �� ������ � xml-�������

       * ��� ������ ���� array('��������', array('��������'))

       * @var array|string $data

       */

      public function __construct($data) {

          if (is_array($data)) {

            list($this->tagName, $this->attributes) = $data;

          } else if (is_string($data))

              $this->parse($data);

      }

         

      /**

       * ����� ��� ������� � ���������� ��������

       * @return stirng

       */

      public function __toString() {

          return $this->cdata;

      }

         

      /**

       * ������ � ������� ��� ������� ��������

       * @var string $name

       * @return XML|array

       */

      public function __get($name) {

          if (isset($this->childs[$name])) {

            if (count($this->childs[$name]) == 1)

                  return $this->childs[$name][0];

            else

                  return $this->childs[$name];

          }

          throw new Exception("UFO steals [$name]!");

      }

         

      /**

       * ������ � ��������� �������� ��������

       * @var string $offset

       * @return mixed

       */

      public function offsetGet($offset) {

          if (isset($this->attributes[$offset]))

            return $this->attributes[$offset];

            throw new Exception("Holy cow! There is'nt [$offset] attribute!");

      }

         

      /**

       * �������� �� ������������� ��������

       * @var string $offset

       * @return bool

       */

      public function offsetExists($offset) {

          return isset($this->attributes[$offset]);

      }

         

      /**

       * �������

       */

      public function offsetSet($offset, $value) { return; }

      public function offsetUnset($offset) { return; }

     

      /**

       * ���������� ���������� ��������� � ���� ������ � ��������

       * @return integer

       */

      public function count() {

            if ($this->parent != null)

                  return count($this->parent->childs[$this->tagName]);

            return 1;

      }

         

      /**

       * ���������� �������� �� ������� ����������� ���������

       * @return ArrayIterator

       */

      public function getIterator() {

            if ($this->parent != null)

                  return new ArrayIterator($this->parent->childs[$this->tagName]);

            return new ArrayIterator(array($this));

      }

     

      /**

       * �������� ������ ���������

       * @return array

       */

      public function getAttributes() {

            return $this->attributes;

      }

         

      /**

       * �������� �������

       * @var string $tag

       * @var array $attributes

       * @return XML

       */

      public function appendChild($tag, $attributes) {

          $element = new XML(array($tag, $attributes));

          $element->setParent($this);

          $this->childs[$tag][] = $element;

          return $element;

      }

         

      /**

       * ���������� ������������ �������

       * @var XML $parent

       */

      public function setParent(XML $parent) {

          $this->parent =& $parent;

      }

         

      /**

       * �������� ������������ �������

       * @return XML

       */

      public function getParent() {

          return $this->parent;

      }

         

      /**

       * ���������� ������ ��������

       * @var string $cdata

      */

      public function setCData($cdata) {

          $this->cdata = $cdata;

      }

         

      /**

       * ������ xml-������ � ������ ������ ���������

       * @var string $data

       */

      private function parse($data) {

          $this->pointer =& $this;

          $parser = xml_parser_create();

          xml_set_object($parser, $this);

          xml_parser_set_option($parser, XML_OPTION_CASE_FOLDING, false);

          xml_set_element_handler($parser, "tag_open", "tag_close");

          xml_set_character_data_handler($parser, "cdata");

          xml_parse($parser, $data);

      }

        

      /**

       * ��� �������� ����, ��������� ���� � ������������� ��������� �� ����

       */

      private function tag_open($parser, $tag, $attributes) {

          $this->pointer =& $this->pointer->appendChild($tag, $attributes);

      }

     

      /**

       * ��� ��������� ������

       */

      private function cdata($parser, $cdata) {

          $this->pointer->setCData($cdata);

      }

     

      /**

       * ��� �������� ����, ���������� ��������� �� ������

       */

      private function tag_close($parser, $tag) {

          $this->pointer =& $this->pointer->getParent();

      }

}
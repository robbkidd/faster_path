# encoding: UTF-8
require 'test_helper'

class RelativeTest < Minitest::Test
  def target_method; :relative? end
  def test_it_takes_nil_safely
    refute FasterPath.relative? nil
  end

  def test_it_knows_its_relativeness
    refute FasterPath.relative? '/'
    refute FasterPath.relative? '/a'
    refute FasterPath.relative? '/..'
    assert FasterPath.relative? 'a'
    assert FasterPath.relative? 'a/b'

    if File.dirname('//') == '//'
      refute FasterPath.relative? '//'
      refute FasterPath.relative? '//a'
      refute FasterPath.relative? '//a/'
      refute FasterPath.relative? '//a/b'
      refute FasterPath.relative? '//a/b/'
      refute FasterPath.relative? '//a/b/c'
    end
  end

  def test_it_knows_its_relativeness_in_dos_like_drive_letters
    refute FasterPath.relative? 'A:'
    refute FasterPath.relative? 'A:/'
    refute FasterPath.relative? 'A:/a'
  end if File.dirname("A:") == "A:." # DOSISH_DRIVE_LETTER

  def test_relative_with_unicode_2014
    ['/—', '/—a', '—/..', 'a—', 'a/b—'].each do |string|
      assert_equal(*result_pair(string))
    end
  end
end

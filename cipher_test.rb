# frozen_string_literal: false

require 'minitest/autorun'
require_relative 'cipher_vigenere'

# CipherTest < Minitest::Test
class CipherTest < Minitest::Test
  def test_vigenere_encryption
    encrypter = VigenereEncrypter.new('KEY')
    ciphertext = encrypter.process('PLAINTEXT')
    assert_equal 'ZPYSRROBR', ciphertext
  end

  def test_vigenere_decryption
    decrypter = VigenereDecrypter.new('KEY')
    plaintext = decrypter.process('ZPYSRROBR')
    assert_equal 'PLAINTEXT', plaintext
  end
end

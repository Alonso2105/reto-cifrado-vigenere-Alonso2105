# frozen_string_literal: true

# Clase principal se define la estructura comun.
class Cipher
  def initialize(key)
    @key = key.upcase
  end

  # Se define el metodo process, las subclases deben implementar el metodo con su logica.
  def process(text)
    raise NotImplementedError, "Subclasses must implement 'process' method"
  end
end

# Clase heredada de Cipher
class VigenereCipher < Cipher
  # Se implementa el metodo process que recibe como argumento el texto a cifrar.
  def process(text) # rubocop:disable Metrics/MethodLength
    alphabet = ('A'..'Z').to_a # Crea un array con todas las letras del alfabeto en mayusculas.
    processed_text = '' # Inicia la variable que almacenara el texto cifrado.

    text.chars.each_with_index do |char, index| # Se itera sobre cada caracter del texto.
      if char == ' '
        processed_text << ' ' # Si el caracter es un espacio en blanco se agrega directo a proccesed_text y continua al siguiente caracter.
        next
      end

      char_code = alphabet.index(char.upcase) # Si el caracter no es un espacio en blanco se obtiene el indice que le corresponde en el array y se almacena.
      key_code = alphabet.index(@key[index % @key.length].upcase) # Aqui se obtiene el indice del caracter que corresponde de la clave  y se almacena.
      shifted_code = yield(char_code, key_code) # Se llama a un bloque yield con char_code y key_code como argumentos proporsionados por las subclases.
      processed_text << alphabet[shifted_code]
    end

    processed_text
  end
end

# Clase heredada de VigenereCipher
class VigenereEncrypter < VigenereCipher
  def process(text)
    # Define como se realiza el cifrado
    super(text) do |char_code, key_code|
      (char_code + key_code) % 26
    end
  end
end

class VigenereDecrypter < VigenereCipher
  def process(text)
    # Define como se realiza el descifrado
    super(text) do |char_code, key_code|
      (char_code - key_code) % 26
    end
  end
end

# Ejemplo de uso

# el usuario ingresa una clave de cifrado y un texto
puts 'Ingresa la clave:'
key = gets.chomp

puts 'Ingresa el texto:'
text = gets.chomp

# Se crea la instancia de VigenereEncrypter y se cifra el texto
encrypter = VigenereEncrypter.new(key)
ciphertext = encrypter.process(text)

# Se crea la instancia de VigenereDecrypter y se descifra el texto
decrypter = VigenereDecrypter.new(key)
plaintext = decrypter.process(ciphertext)

# Salida en consola
puts "Texto original: #{text}" # Texto a cifrar
puts "Texto cifrado: #{ciphertext}" # Texto cifrado
puts "Texto descifrado: #{plaintext}"  # Texto descifrado

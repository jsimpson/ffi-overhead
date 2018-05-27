require 'ffi'

module Hello
  class C
    extend FFI::Library

    ffi_lib 'newplus/libnewplus.so'

    functions = [
      [:current_timestamp, [],           :long_long],
      [:plus,              [:int, :int], :int],
      [:plusone,           [:int],       :int]
    ]

    functions.each do |function|
      begin
        attach_function *function
      rescue Object => e
        puts "Could not attach #{function}, #{e.message}"
      end
    end
  end
end

def run(count)
  start = Hello::C.current_timestamp

  x = 0
  while x < count do
    x = Hello::C.plusone(x)
  end

  puts "#{Hello::C.current_timestamp - start}"
end

run(500000000)


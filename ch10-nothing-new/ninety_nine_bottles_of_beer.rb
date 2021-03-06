def english_number number
  if number < 0 # No negative numbers.
    return 'Please enter a number that isn\'t negative.'
  elsif number == 0
    return 'zero'
  end

  num_string = ''                 # This is the string we will return.
  ones_place = ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']
  tens_place = ['ten', 'twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety']
  teenagers = ['eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen', 'seventeen', 'eighteen', 'nineteen']
    
  left = number                       # "left" is how much of the number we still have left to write out.

  # WRITE BILLIONS COLUMN
  write = left / 1000000000000                 # "write" is the part we are writing out right now. How many hundreds left?
  left = left - write * 1000000000000     # Subtract off those hundreds.
  
  if write > 0
    trillions = english_number write     # Now here's the recursion:
    num_string = num_string + trillions + ' trillion'
    if left > 0
      num_string = num_string + ' '       
    end
  end

  # WRITE BILLIONS COLUMN
  write = left / 1000000000                 
  left = left - write * 1000000000     
  
  if write > 0
    billions = english_number write     # Now here's the recursion:
    num_string = num_string + billions + ' billion'
    if left > 0
      num_string = num_string + ' '       
    end
  end

  # WRITE MILLIONS COLUMN
  write = left / 1000000                 
  left = left - write * 1000000          
  
  if write > 0
    millions = english_number write     # Now here's the recursion:
    num_string = num_string + millions + ' million'
    if left > 0
      num_string = num_string + ' '       # So we don't write 'two hundredfifty-one'...
    end
  end

  # WRITE THOUSANDS COLUMN
  write = left / 1000                 
  left = left - write * 1000         
  
  if write > 0
    thousands = english_number write     # Now here's the recursion:
    num_string = num_string + thousands + ' thousand'
    if left > 0
      num_string = num_string + ' '       # So we don't write 'two hundredfifty-one'...
    end
  end

  # WRITE HUNDREDS COLUMN
  write = left / 100                  # "write" is the part we are writing out right now. How many hundreds left?
  left = left - write * 100           # Subtract off those hundreds.
  
  if write > 0
    hundreds = english_number write     # Now here's the recursion:
    num_string = num_string + hundreds + ' hundred'
    if left > 0
      num_string = num_string + ' '       # So we don't write 'two hundredfifty-one'...
    end
  end

  # WRITE TENS COLUMN
  write = left / 10                   # How many tens left?
  left = left - write * 10            # Subtract off those tens.
  
  if write > 0
    if ((write == 1) and (left > 0)) # Since we can't write "tenty-two" instead of "twelve", we have to make a special exception for these.
      num_string = num_string + teenagers[left - 1] # The "-1" is because teenagers[3] is 'fourteen', not 'thirteen'. Since we took care of the digit in the ones place already, we have nothing left to write.
      left = 0
    else
      num_string = num_string + tens_place[write - 1] # The "-1" is because tens_place[3] is 'forty', not 'thirty'.
    end
  
    if left > 0
      num_string = num_string + '-'
    end
  end
  
  # WRITE ONES COLUMN
  write = left # How many ones left to write out?
  left = 0 # Subtract off those ones.
  if write > 0
    num_string = num_string + ones_place[write - 1]
    # The "-1" is because ones_place[3] is 'four', not 'three'.
  end

  # Now we just return "num_string"...
  num_string
end

def bottles_of_beer(bottles)
  bottles.downto(1) do |b|
    if b == 1 
      puts english_number(b).to_s.capitalize + ' bottle of beer on the wall'
      puts english_number(b).to_s.capitalize + ' bottle of beer'
    else
      puts english_number(b).to_s.capitalize + ' bottles of beer on the wall'
      puts english_number(b).to_s.capitalize + ' bottles of beer'
    end
    puts 'Take one down, pass it around,'
    if (b-1) == 1
      puts english_number(b - 1).to_s.capitalize + ' bottle of beer on the wall.'
    elsif (b - 1) > 1
      puts english_number(b - 1).to_s.capitalize + ' bottles of beer on the wall.'
    else
      puts 'No bottles of beer on the wall.'
    end
  end
end

bottles_of_beer(99)

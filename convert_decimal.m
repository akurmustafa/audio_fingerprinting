function [decimal_number] = convert_decimal(binary_vector)
% Converts deciaml to binary vector
%   Detailed explanation goes here
    decimal_number = 0;
    count=0;
    vector_length = length(binary_vector);
    while count < length(binary_vector)
        decimal_number = decimal_number + 2^count*binary_vector(vector_length - count);
        count=count+1;
    end
end
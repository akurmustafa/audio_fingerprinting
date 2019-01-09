function [binaryVector] = convertBinary(decimalNumber, bitNum)
% Converts deciaml to binary vector
%   Detailed explanation goes here
    binaryVector=zeros(1, bitNum);
    count=0;
    while decimalNumber>0
        binaryVector(bitNum-count)=rem(decimalNumber,2);
        decimalNumber=fix(decimalNumber/2);
        count=count+1;
    end
end


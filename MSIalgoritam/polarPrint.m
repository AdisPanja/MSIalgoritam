function [polar, isSymmetric] = polarPrint(A)
    epsilon     = 10^(-6);
    absA        = abs(A);
    phaseA      = angle(A)*180/pi;
    isSymmetric = 1;
    
    if abs(absA(1) - absA(2)) > epsilon || abs(absA(1) - absA(3)) > epsilon || abs(absA(2) - absA(3)) > epsilon
        isSymmetric = 0;
    end
    
    if abs(A(1) + A(2) + A(3)) > epsilon
        isSymmetric = 0;
    end
    
    polar = arrayfun(@(x, y) sprintf('%f < %f', x, y), absA, phaseA, 'uni', 0);
end
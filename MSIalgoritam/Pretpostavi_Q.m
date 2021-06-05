function NoviCvorovi = Pretpostavi_Q(cvorovi)

    NoviCvorovi = cvorovi;
    br = 0;
    
    for i = 1:length(NoviCvorovi)
        if (NoviCvorovi{i,1}{1,1} == 'PV')
            br = br+1;
            NoviCvorovi{i,1}{1,2}(1,2) = NoviCvorovi{i,1}{1,2}(1,2)-j*0;
        end
    end
end
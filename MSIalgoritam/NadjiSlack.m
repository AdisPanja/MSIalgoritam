function [v_slack, index] = NadjiSlack(cvorovi)
    
    for i = 1:length(cvorovi)
        if (cvorovi{i,1}{1,1} == "SLACK")
            v_slack = cvorovi{i,1}{1,2};
            index = i;
            break;
        end
    end
end
function V = BazniAlgoritam(inv_Y_L, inv_Y_U, cvorovi, epsilon)
    
    n = length(cvorovi); %broj cvorova
    [v_slack, index_slack] = NadjiSlack(cvorovi);
        
    V_k_1 = zeros(n,1); %vektor napona cvorova u (k-1)-oj iteraciji
    I = zeros(n,1); %vektor struja injektovanih u cvorove sistema
    I(index_slack, 1) = v_slack;
    
    V_k_1(:,1) = v_slack;

    k_max = 1000; %maksimalan broj iteracija
    
    for k=1:k_max+1       
        if (k > k_max)
            V = zeros(n,1);
            break;
        end
        for i=1:n
            if (i ~= index_slack) 
                if (cvorovi{i,1}{1,1} == "PQ" && cvorovi{i,1}{1,3} == "Nezavisan")
                    s_i = cvorovi{i,1}{1,2};   
                elseif (cvorovi{i,1}{1,1} == "PQ" && cvorovi{i,1}{1,3} == "Zavisan")
                    s_i = PrividnaSnagaZavisnogPQcvora(cvorovi{i,1}, V_k_1(i));
                elseif (cvorovi{i,1}{1,1} == "PV")
                    s_i = cvorovi{i,1}{1,2}(1,2);   
                end
                I(i) = conj(-s_i/V_k_1(i));
            end
        end
        V_k = inv_Y_U*inv_Y_L*I;
        
         if (max(abs(V_k-V_k_1))) < epsilon
             V = V_k;
             break;
         end      
        V_k_1 = V_k;
    end
end
        
        
    
    
    
function Y = MatricaAdmitansi(n, y)

    Y = zeros(n,n); %Inicijalizacija matrice admitansi
    
    for i = 1:n
        for j = 1:n            
            
            %Radi se o elementu sa glavne dijagonale%
            if (i == j) 
                ElemNaGlDijag = 0;
                for k = 1:length(y)
                    %Traze se sve admitanse iz vektora 'y', koje ulaze u dati cvor%
                    if (i == str2num(y{k,2}) || i == str2num(y{k,3})) 
                        ElemNaGlDijag = ElemNaGlDijag + y{k,1};       
                    end
                end
                Y(i,j) = ElemNaGlDijag;
            
            %Radi se o vandijagonalnom elementu%
            else 
                ElemNaSporDijag = 0;
                for k = 1:length(y)
                     %Traze se sve admitanse iz vektora 'y', koje se nalaze izmedju dva data cvora%
                    if (i == str2num(y{k,2}) && j == str2num(y{k,3}) || i == str2num(y{k,3}) && j == str2num(y{k,2}))
                        ElemNaSporDijag = ElemNaSporDijag + y{k,1};
                    end
                end
                Y(i,j) = -ElemNaSporDijag;
            end
        end
    end
end


    
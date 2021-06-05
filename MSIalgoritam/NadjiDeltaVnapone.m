function delta_V = NadjiDeltaVnapone(V_k, PozicijePVcvorova, cvorovi)

    V_k_PV = zeros(length(PozicijePVcvorova),1); %inicijalizacija
    delta_V = V_k_PV;
    
    %smjestanje izracunatih napona PV cvorova u vektor%
    for i = 1:length(PozicijePVcvorova)
        V_k_PV(i) = V_k(PozicijePVcvorova(i)); 
    end
    
    %formiranje razlike izmedju izracunatih napona PV cvorova i njihovih regulisanih napona%
    %te smjestanje u finalni vektor%
    for i = 1:length(delta_V)
        delta_V(i) = abs(V_k_PV(i)) - abs(cvorovi{PozicijePVcvorova(i),1}{1,2}(1,1)); 
    end
end
            
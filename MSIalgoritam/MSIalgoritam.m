function [V, k_rez] = MSIalgoritam(cvorovi, y, epsilon)

    %provjera unosa%
    if (ProvjeriUnos(cvorovi) == 0)
        V = [];
        k_rez = 0;
        return;
    end
    n = length(cvorovi); %ukupni broj cvorova
    PozicijePVcvorova = NadjiPVcvorove(cvorovi); %vraca indekse PV cvorova
    n_g = length(PozicijePVcvorova); %ukupni broj PV cvorova
    delta_Q_k_1 = zeros(n_g,1); %matrica (k-1)-ih koraka
    delta_Q_k = zeros(n_g,1); %matrica k-tih koraka
    H = zeros(n_g,n_g); %matrica senzitivnosti
    k_max = 1000; %maksimalan broj iteracija
        
    Y = MatricaAdmitansi(n, y); %formiranje matrice admitansi
    [v_slack, index_slack] = NadjiSlack(cvorovi); %pronalazenje slack cvora
    
    Y(index_slack,:) = zeros(1,size(Y,2)); 
    Y(index_slack,index_slack) = 1;              

    [Y_L, Y_U] = lu(Y); %faktorizacija sistemske matrice admitansi
    inv_Y_L = inv(Y_L);
    inv_Y_U = inv(Y_U);
    
    NoviCvorovi = Pretpostavi_Q(cvorovi); %pretpostavljamo vrijednosti reaktivnih snaga PV cvorova
    
    if (n_g ~= 0) %ukoliko se u mrezi nalazi PV cvor
    
        for k = 1:k_max+1
            if (k >= k_max)
                V = [];
                k_rez = k;
                disp('Proracun nije uspio. Dosegnut maksimalan broj iteracija.');
                break;
            end

            V_Q = BazniAlgoritam(inv_Y_L, inv_Y_U, NoviCvorovi, epsilon);
            if (V_Q == zeros(n,1))
                V = [];
                k_rez = k;
                disp('Proracun nije uspio. Dosegnut maksimalan broj iteracija prilikom rjesavanja baznog algoritma.');
                break;
            end             
                
            delta_V = NadjiDeltaVnapone(V_Q, PozicijePVcvorova, cvorovi);

            %Popunjavanje matrice senzistivnosti H%    
            for i = 1:n_g
                for m = 1:n_g
                    PomocniCvorovi = NoviCvorovi;
                    p_i = real(cvorovi{PozicijePVcvorova(m),1}{1,2}(1,2));
                    q_i = imag(NoviCvorovi{PozicijePVcvorova(m),1}{1,2}(1,2));
                    PomocniCvorovi{PozicijePVcvorova(m),1}{1,2}(1,2) = p_i+j*(q_i+1e-3);
                    V_Q_delta_Q = BazniAlgoritam(inv_Y_L, inv_Y_U, PomocniCvorovi, epsilon);                   

                    %Numericko trazenje parcijalnog izvoda%
                    ParcIzvod = (abs(V_Q_delta_Q(PozicijePVcvorova(i),1))-abs(V_Q(PozicijePVcvorova(i),1)))/1e-3;
                    H(i,m) = ParcIzvod;
                end
            end

            if (det(H) == 0)
                V = [];
                k_rez = k;
                disp('Proracun nije uspio. Matrica senzitivnosti H je singularna');
                break;
            end

            delta_Q_k = inv(H)*delta_V;

            if (max(abs(delta_Q_k-delta_Q_k_1)) <= epsilon)
                V = V_Q_delta_Q;
                k_rez = k;
                break;
            else
                %update vrijednosti reaktivne snage za PV ?vorove%
                for i=1:n_g
                    p_i = real(cvorovi{PozicijePVcvorova(i),1}{1,2}(1,2));
                    q_i = imag(NoviCvorovi{PozicijePVcvorova(i),1}{1,2}(1,2));
                    q_i = q_i-delta_Q_k(i);                  
                    NoviCvorovi{PozicijePVcvorova(i),1}{1,2}(1,2) = p_i+j*q_i;
                end
                delta_Q_k_1 = delta_Q_k;
            end
        end
        
    else %ukoliko se u mrezi ne nalazi PV cvor
        V = BazniAlgoritam(inv_Y_L, inv_Y_U, cvorovi, epsilon);
        k_rez = 0;        
    end    
end


        
   
    
        
        
        

    

    
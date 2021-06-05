function provjera = ProvjeriUnos(cvorovi)

    n = length(cvorovi);
    provjera = 1;
    
    for i = 1:n
        ime_cvora = cvorovi{i,1}{1,1};
        if (ime_cvora ~= "SLACK" && ime_cvora ~= "PQ" && ime_cvora ~= "PV")
            fprintf('Netacan unos cvorova. Pokusajte ponovo.\n Raspolozivi cvorovi su:\n 1. SLACK\n 2. PQ\n 3. PV\n');
            provjera = 0;
            break;
            
        elseif (ime_cvora == 'PQ')
            zavisnost = cvorovi{i,1}{1,3};
            if (zavisnost ~= "Zavisan" && zavisnost ~= "Nezavisan")
                fprintf('Netacan unos PQ cvora. Pokusajte ponovo. Raspolozivi unosi su:\n 1. Zavisan\n 2. Nezavisan\n');
                provjera = 0;
                break;
            elseif (length(cvorovi{i,1}) ~= 3)
                fprintf('PQ cvor nije pravilno unesen. Pokusajte ponovo.\n Format unosa je {"PQ", s_i, "Zavisan/Nezavisan"}\n');
                provjera = 0;
                break;
            end
            
        elseif (ime_cvora == "SLACK")
            if (length(cvorovi{i,1}) ~= 2)
                fprintf('SLACK cvor nije pravilno unesen. Pokusajte ponovo.\n Format unosa je {"SLACK", v_i}\n');
                provjera = 0;
                break;
            end
            
        elseif (ime_cvora == "PV")
            if (length(cvorovi{i,1}) ~= 2)
                fprintf('PV cvor nije pravilno unesen. Pokusajte ponovo.\n Format unosa je {"PV", [v_i,p_i]}\n');
                provjera = 0;
                break;
            end
        end
    end
end
                        
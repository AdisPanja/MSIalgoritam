function s_i = PrividnaSnagaZavisnogPQcvora(PQcvor, v_i)

    p_i = PQcvor{1,2}(1,1);
    kz_p = PQcvor{1,2}(1,2);
    ki_p = PQcvor{1,2}(1,3);
    kp_p = PQcvor{1,2}(1,4);
    
    q_i = PQcvor{1,2}(2,1);
    kz_q = PQcvor{1,2}(2,2);
    ki_q = PQcvor{1,2}(2,3);
    kp_q = PQcvor{1,2}(2,4);
    
    s_i = p_i*(kz_p*abs(v_i)^2+ki_p*abs(v_i)+kp_p)+j*q_i*(kz_q*abs(v_i)^2+ki_q*abs(v_i)+kp_q);
end
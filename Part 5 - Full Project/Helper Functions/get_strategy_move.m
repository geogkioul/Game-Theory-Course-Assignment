function move = get_strategy_move(player_strategy, history, player_id)
% Every new strategy implemented should be also added here
    switch player_strategy
            case 'All-D'
                move = all_d(history, player_id);
            case 'All-C'
                move = all_c(history, player_id);
            case 'TitForTat'
                move = tft(history, player_id);
            case '(CCCCD)*'
                move = per_ccccd(history, player_id);
            case '(CD)*'
                move = per_cd(history, player_id);
            case '(DDC)*'
                move = per_ddc(history, player_id);
            case '(CCD)*'
                move = per_ccd(history, player_id);
            case 'Soft-Majo'
                move = soft_majo(history, player_id);
            case 'Prober'
                move = prober(history, player_id);
            case 'Gradual'
                move = gradual(history, player_id);
            otherwise
                error('Uknown strategy');
    end
end
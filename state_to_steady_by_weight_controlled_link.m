function steady_state = state_to_steady_by_weight_controlled_link(adj,basal,start_state,link_controlled,link_controlled_value,link_controlled_percent)

% from 'start_state' to 'steay state'    

    n_node=size(adj,1);
    lc=find(link_controlled);    
%     link_list=find(adj);
    next_state=start_state;
    
    for i=1:50
        now_state=next_state;
        next_state=next(now_state);            
    end
    
    steady_state=zeros(50,n_node);
    for i=1:50
        steady_state(i,:)=next_state;
        next_state=next(steady_state(i,:));            
    end
    
% weighted simple rule    
% controlling 'link_controlled' as 'link_controlled_value'
    function next_state=next(now_state)
        adj_controlled=adj;
        lc2=rand(1,length(lc))<link_controlled_percent(lc);
        adj_controlled(lc(lc2))=link_controlled_value(lc(lc2));
        
        wsum=now_state*adj_controlled+basal;
        next_state=now_state;
        next_state(wsum>0)=1;
        next_state(wsum<0)=0;
    end

end
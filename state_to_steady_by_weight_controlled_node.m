function steady_state = state_to_steady_by_weight_controlled_node(adj,basal,start_state,node_controlled,node_controlled_value,node_controlled_percent)

% from 'start_state' to 'steay state'

    n_node=size(adj,1);
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
% controlling 'node_controlled' as 'node_controlled_value'
    function next_state=next(now_state)
        wsum=now_state*adj+basal;
        next_state=now_state;
        next_state(wsum>0)=1;
        next_state(wsum<0)=0;
        
        nc=find(node_controlled);
        nc2=rand(1,length(nc))<node_controlled_percent(nc);
        next_state(nc(nc2))=node_controlled_value(nc(nc2));
    end
end
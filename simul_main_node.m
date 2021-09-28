function steady_state_list=simul_main_node(fname, dna, node_controlled, node_controlled_value, per,initial_state)

load(fname)
n_node=16;
node_controlled_percent=zeros(1,n_node);
n_sample=size(initial_state,1);
if(dna==0)
    
    node_controlled_percent=zeros(1,n_node);
    
    for j=1:length(per)
        node_controlled_percent(find(node_controlled))=per(j);
        for i=1:n_sample
            steady_state = state_to_steady_by_weight_controlled_node(adj_0,basal_of_node_0,initial_state(i,:),node_controlled,node_controlled_value,node_controlled_percent);
            %             temp=mean(steady_state);
            temp(i,:)=mean(steady_state);
        end
        steady_state_list{j}=temp;
    end
    
else
    
    node_controlled_percent=zeros(1,n_node);
    
    for j=1:length(per)
        node_controlled_percent(find(node_controlled))=per(j);
        for i=1:n_sample
            steady_state = state_to_steady_by_weight_controlled_node(adj_1,basal_of_node_1,initial_state(i,:),node_controlled,node_controlled_value,node_controlled_percent);
            %             temp=mean(steady_state);
            %             value_list{j}(i)=temp(16);
            temp(i,:)=mean(steady_state);
        end
        steady_state_list{j}=temp;
        
    end
    
end

end

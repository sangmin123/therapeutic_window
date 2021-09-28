function steady_state_list=simul_main_link(fname, dna, link_controlled, link_controlled_value, per, initial_state)

load(fname)
n_link=16;
link_controlled_percent=zeros(1,n_link);
n_sample=size(initial_state,1);
if(dna==0)
    
    link_controlled_percent=zeros(1,n_link);
    
    for j=1:length(per)
        link_controlled_percent(find(link_controlled))=per(j);
        for i=1:n_sample
            steady_state = state_to_steady_by_weight_controlled_link(adj_0,basal_of_node_0,initial_state(i,:),link_controlled,link_controlled_value,link_controlled_percent);
            %             temp=mean(steady_state);
            temp(i,:)=mean(steady_state);
        end
        steady_state_list{j}=temp;
    end
    
else
    
    link_controlled_percent=zeros(1,n_link);
    
    for j=1:length(per)
        link_controlled_percent(find(link_controlled))=per(j);
        for i=1:n_sample
            steady_state = state_to_steady_by_weight_controlled_link(adj_1,basal_of_node_1,initial_state(i,:),link_controlled,link_controlled_value,link_controlled_percent);
            %             temp=mean(steady_state);
            %             value_list{j}(i)=temp(16);
            temp(i,:)=mean(steady_state);
        end
        steady_state_list{j}=temp;
        
    end
    
end

end

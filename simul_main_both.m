function steady_state_list=simul_main_both(fname, dna, node_controlled, node_controlled_value,link_controlled, link_controlled_value, per, initial_state)

load(fname)
n_sample=size(initial_state,1);

n_node=16;
node_controlled_percent=zeros(1,n_node);
n_link_possible=16*16;
link_controlled_percent=zeros(1,n_link_possible);

if(dna==0)
    
    for j=1:length(per)
        link_controlled_percent(find(link_controlled))=per(j);
        node_controlled_percent(find(node_controlled))=per(j);            
        for i=1:n_sample
            steady_state = state_to_steady_by_weight_controlled_both(adj_0,basal_of_node_0,initial_state(i,:),node_controlled,node_controlled_value,node_controlled_percent,link_controlled,link_controlled_value,link_controlled_percent);
            temp=mean(steady_state);
            steady_state_list{j}(i)=temp(16);
        end
    end
    
else
    
    for j=1:length(per)
        link_controlled_percent(find(link_controlled))=per(j);
        node_controlled_percent(find(node_controlled))=per(j);            
        for i=1:n_sample
            steady_state = state_to_steady_by_weight_controlled_both(adj_1,basal_of_node_1,initial_state(i,:),node_controlled,node_controlled_value,node_controlled_percent,link_controlled,link_controlled_value,link_controlled_percent);
            temp=mean(steady_state);
            steady_state_list{j}(i)=temp(16);
        end
%         basin(j)=nnz(steady_state_list{j}(:,16)>0.9);
    end
    
end



end

clc; clear; tic;

load NT_control;
n_node=16;
load initial_state_16;
NT_list=[2 3 5 6 7 8 9 10 11 13 15 17 19 22 23 24 28 29 34]; %Cell line-specific networks

n_sample=2^n_node;
temp=randperm(2^n_node);
initial_state_sampled=initial_state(temp(1:n_sample),:);

node_controlled_value=zeros(1,n_node); %control to 0
link_controlled_value=zeros(1,n_node*n_node); %control to 0
per=0:0.1:1;

%% node
node_control_set=[9, 14, 10, 3,5,1]; %ABCMWA
for NT=NT_list
    for dna=0:1
        parfor i=1:length(node_control_set)
            nc=node_control_set(i);
            node_controlled=zeros(1,n_node);
            node_controlled(nc)=1;
            result_temp{i}=simul_main_node(['NT_cell/NT_' num2str(NT)],dna,node_controlled, node_controlled_value, per,initial_state_sampled);
        end
        node_single(NT,dna+1,:)=result_temp;
    end
end

%% link
adj_mapping=abs(sign(adj_0));
for i=1:length(node_control_set)
    adj_mapping(node_control_set(i),:)=adj_mapping(node_control_set(i),:)*(i+1);
end
link_control_set=find(adj_mapping >1)';
% '>1' -> links of all nodes
% '==2' -> links of AKT
% '==6' -> links of ATM

for NT=NT_list
    for dna=0:1
        parfor i=1:length(link_control_set)
            link_controlled=zeros(1,n_node*n_node);
            link_controlled(link_control_set(i))=1;
            result_temp{i}=simul_main_link(['NT_cell/NT_' num2str(NT)],dna,link_controlled, link_controlled_value, per,initial_state_sampled);
        end
        link_single(NT,dna+1,:)=result_temp;
    end
end

%% node-node combi
node_control_set_combi=nchoosek(node_control_set,2);
for NT=NT_list
    for dna=0:1
        parfor i=1:size(node_control_set_combi,1)
            node_controlled=zeros(1,n_node);
            node_controlled(node_control_set_combi(i,:))=1;
            result_temp{i}=simul_main_node(['NT_cell/NT_' num2str(NT)],dna,node_controlled, node_controlled_value, per,initial_state_sampled);
        end
        node_combi(NT,dna+1,:)=result_temp;        
    end
end

%% node-link combi
for NT=NT_list
    for dna=0:1
        ttt=0;
        for i=node_control_set
            link_list=setdiff(link_control_set,find(adj_mapping==i+1));
            for j=1:length(link_list) %exclude N/A
                ttt=ttt+1;
                link_controlled=zeros(1,n_node*n_node);
                link_controlled(link_list(j))=1;
                node_controlled=zeros(1,n_node);
                node_controlled(i)=1;
                result_temp{ttt}=simul_main_both(['NT_cell/NT_' num2str(NT)],dna,node_controlled, node_controlled_value, link_controlled, link_controlled_value, per,initial_state_sampled);
            end
        end
        node_link_both(NT,dna+1,:)=result_temp;                
    end
end

%% link-link combi
link_control_set_combi=nchoosek(link_control_set,2);
for i=1:length(node_control_set)
    link_from_same_node=find(adj_mapping==i+1);
    link_control_set_combi=setdiff(link_control_set_combi,nchoosek(link_from_same_node,2),'rows'); %exclude N/A
end
for NT=NT_list
    for dna=0:1
        parfor i=1:size(link_control_set_combi,1)
            link_controlled=zeros(1,n_node*n_node);
            link_controlled(link_control_set_combi(i,:))=1;
            result_temp{i}=simul_main_link(['NT_cell/NT_' num2str(NT)],dna,link_controlled, link_controlled_value, per, initial_state_sampled);
        end
        link_combi(NT,dna+1,:)=result_temp;        
    end
end


clc; clear;
load result_total
per=0:0.1:1;

figure

% node single
NT=8; node1=1;
cancer=node_single{NT,2,node1}/65536;
normal=node_single{7,2,node1}/65536;
func_plot(normal,cancer,node_single_list{node1},['NT ' num2str(NT)],per)

% node combi
NT=9; node1=1; node2=5;
cancer=node_combi{NT,2,node1,node2}/65536;
normal=node_combi{7,2,node1,node2}/65536;
func_plot(normal,cancer,[node_single_list{node1} '  ' node_single_list{node2}],['NT ' num2str(NT)],per)

% link single
NT=8; link1=12;
cancer=link_combi{NT,2,link1,link1}/65536;
normal=link_combi{7,2,link1,link1}/65536;
func_plot(normal,cancer,link_single_list{link1},['NT ' num2str(NT)],per)

% link combi
NT=9; link1=2; link2=21;
cancer=link_combi{NT,2,link1,link2}/65536;
normal=link_combi{7,2,link1,link2}/65536;
func_plot(normal,cancer,[link_single_list{link1} '  ' link_single_list{link2}],['NT ' num2str(NT)],per)

% node_link_both
NT=9; node1=1; link1=16;
cancer=node_link_both{NT,2,node1,link1}/65536;
normal=node_link_both{7,2,node1,link1}/65536;
func_plot(normal,cancer,[node_single_list{node1} ' & ' link_single_list{link1}],['NT ' num2str(NT)],per)

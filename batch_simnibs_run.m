%path_to_headmodels = "/home/tpsych7/Gaurav_Simnibs_tDCS/simulations/Anushree_data/Freesurfer_segs_models/check_auto_vs_manual_elec_pos";
path_to_headmodels='/home/tpsych7/Gaurav_Simnibs_tDCS/hd_snf_15-10-2019/Remaining';
%subjects=["C0019","C0020","C0030","C0034","C0046","C0054","C0055","C0085","C0091","C0097","C0102","C0110","C0113","C0132","C0137","C0155","C0159","C0167","C0185","C0201","C0218","C0231"];
subjects=["anand","ANITHA","BHUVANESHWARI","ganesh","JYOTHI","manjunath","manjunathTN","MANJUNATHV","manohar","NARATHNA","naresh","NARESHV","pradeepthi","raghu","rajeev","rajesh","REKHA","rilna","sagira","SATISHCHANDRA","srivalli","SUGUNA"];
S = sim_struct('SESSION');
S.map_to_fsavg = true; % Transform simulation results to FSAverage space
S.map_to_MNI = true; % Transform simulation results to MNI space

S.poslist{1} = sim_struct('TDCSLIST');
S.poslist{1}.currents = [0.0005, 0.0005, 0.0005, 0.0005, -0.002]; % Currents flowing through each channel, in Ampere. Positive values designate anodes, negative values cathodes

S.poslist{1}.electrode(1).channelnr = 5;  % Connect the electrode to the first channel. That is, this electrode is an anode with a current of 2mA
S.poslist{1}.electrode(1).centre = 'CP5';  % Place it over C3
%S.poslist{1}.electrode(1).pos_ydir = 'FC1'; % Electrodes y axis points towards C3
S.poslist{1}.electrode(1).shape = 'ellipse';  % Rectangular shape
S.poslist{1}.electrode(1).dimensions = [20, 20];  % 50x50 mm
S.poslist{1}.electrode(1).thickness = [5, 2];  % 4 mm thickness

S.poslist{1}.electrode(2).channelnr = 1;  % Connect the electrode to the first channel. That is, this electrode is an anode with a current of 2mA
S.poslist{1}.electrode(2).centre = 'PO7';  % Place it over C3
%S.poslist{1}.electrode(2).pos_ydir = 'FC1'; % Electrodes y axis points towards C3
S.poslist{1}.electrode(2).shape = 'ellipse';  % Rectangular shape
S.poslist{1}.electrode(2).dimensions = [20, 20];  % 50x50 mm
S.poslist{1}.electrode(2).thickness = [5, 2];  % 4 mm thickness

S.poslist{1}.electrode(3).channelnr = 2;  % Connect the electrode to the first channel. That is, this electrode is an anode with a current of 2mA
S.poslist{1}.electrode(3).centre = 'FT7';  % Place it over C3
%S.poslist{1}.electrode(3).pos_ydir = 'FC1'; % Electrodes y axis points towards C3
S.poslist{1}.electrode(3).shape = 'ellipse';  % Rectangular shape
S.poslist{1}.electrode(3).dimensions = [20, 20];  % 50x50 mm
S.poslist{1}.electrode(3).thickness = [5, 2];  % 4 mm thickness

S.poslist{1}.electrode(4).channelnr = 3;  % Connect the electrode to the first channel. That is, this electrode is an anode with a current of 2mA
S.poslist{1}.electrode(4).centre = 'FC3';  % Place it over C3
%S.poslist{1}.electrode(4).pos_ydir = 'FC1'; % Electrodes y axis points towards C3
S.poslist{1}.electrode(4).shape = 'ellipse';  % Rectangular shape
S.poslist{1}.electrode(4).dimensions = [20, 20];  % 50x50 mm
S.poslist{1}.electrode(4).thickness = [5, 2];  % 4 mm thickness

S.poslist{1}.electrode(5).channelnr = 4;  % Connect the electrode to the first channel. That is, this electrode is an anode with a current of 2mA
S.poslist{1}.electrode(5).centre = 'P1';  % Place it over C3
%S.poslist{1}.electrode(5).pos_ydir = 'FC1'; % Electrodes y axis points towards C3
S.poslist{1}.electrode(5).shape = 'ellipse';  % Rectangular shape
S.poslist{1}.electrode(5).dimensions = [20, 20];  % 50x50 mm
S.poslist{1}.electrode(5).thickness = [5, 2];  % 4 mm thickness

%S.fnamehead='/home/tpsych7/Gaurav_Simnibs_tDCS/age_matched_sims/spm_sims/C0019/C0019.msh';
%S.pathfem='/home/tpsych7/Gaurav_Simnibs_tDCS/age_matched_sims/spm_sims/C0019/bipolar';
S.fnamehead = char(fullfile(path_to_headmodels, subjects, subjects+'.msh'));  % head mesh
S.pathfem = char(fullfile(path_to_headmodels, subjects, 'hd')); % Output directoryrun_simnibs(S)end

for sub = subjects
    S.fnamehead = char(fullfile(path_to_headmodels, sub, sub+'.msh'));  % head mesh
    S.pathfem = char(fullfile(path_to_headmodels, sub, 'hd')); % Output directory
    run_simnibs(S)
end
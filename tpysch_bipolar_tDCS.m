function tpysch_bipolar_tDCS(dirname,fname,currden)
% This script will process the mesh file and prepare Abaqus inp file for bipolar electrode configuration 
% Input:
% dirname: directory of the inp file;
% fname: name of the inp file without inp extension
% currden: current density (A/m^2) to inject
%
% You will need function meshProcess.m
% Place rnge_gel.mat, rnge_elec.mat in same directory
%
% Modified Code: Sunil Kalmady, June 2016
% Tpsych Lab, NIMHANS, Bangalore
% Original Code 
% (c) Jacek Dmochowski, March 2011
% (c) Yu Huang (Andy), February 2015
% (c) Yu Huang (Andy), March 2014
% (c) Yu Huang (Andy), March 2011
% The Neural Engineering Lab, Dept. of Biomedical Engineering, City College of New York

cd(dirname)
filename_in=[fname '.inp']; % input mesh file name
filename_out=[fname '_abaqus.inp']; % mesh file submitted to Abaqus for solving

% Process the mesh file (.inp) generated from Simpleware.
% Read the mesh file, label the electrodes and gel for solving in Abaqus.
meshProcess(dirname,filename_in,2,1)
fprintf('Generating Abaqus input file...\n');

% PARAMETERS
load en;  % cell array of nodes belonging to each electrode
load ee;  % cell array of elements belonging to each electrode
mkdir('./scratch') % temporary directory used by Abaqus

is = 1; % labels of anodes
ib = 2; % label of grounded electrode (cathode)

sigma=[   ...
    2.5e-14; ...  % air
    0.465; ... % skin
    0.01; ...     % bone
    0.276; ...    % gray
    0.126; ...    % white
    1.65; ...     % csf
    5.9e7; ... % elec
    0.3 ; ... % gel
    ];

% conductivities for all tissue types, coming in the priority order in ScanIP
sigma=sigma(end:-1:1); cc=1;
% because in the mesh file (inp), the 8 tissues come in an inversed order of priority order in ScanIP

%  STEPS 1 & 2 -- add material properties + change all element types to thermal electric
fin = fopen(filename_in);
fout = fopen(filename_out,'w');
while ~feof(fin)
    s = fgetl(fin);
    s = strrep(s, 'C3D4', 'DC3D4E'); % Solving type: thermal electric element
    fprintf(fout,'%s \n',[s]);
    if length(s)>=9
        if strcmp(s(1:9),'*MATERIAL')
            s2='*ELECTRICAL CONDUCTIVITY';
            s3=num2str(sigma(cc)); cc=cc+1;
            fprintf(fout,'%s \n %s \n',s2,s3); % write conductivity values to each tissue type in .inp file
        end
    end
end
fclose(fin);
fclose(fout);

% STEP 3: add boundary condition
% define set of nodes in grounded electrode
M='*NSET, NSET=GELEC';
dlmwrite(filename_out, M, 'delimiter', '','-append');

dlmwrite(filename_out, en{ib}, 'delimiter', ',','-append','precision','%7d');

M='*BOUNDARY';
dlmwrite(filename_out, M, 'delimiter', '','-append');

M='GELEC,9,9';
dlmwrite(filename_out, M, 'delimiter', '','-append');

% STEP 4: add analysis step
% create set of elements that will be energized
M='*ELSET, ELSET=SELEC';
dlmwrite(filename_out, M, 'delimiter', '','-append');
dlmwrite(filename_out, ee{is}, 'delimiter', ',','-append','precision','%7d');

% create surface
M='*SURFACE, TYPE=ELEMENT, NAME=SSURF';
dlmwrite(filename_out, M, 'delimiter', '','-append');

M='SELEC,';
dlmwrite(filename_out, M, 'delimiter', '','-append');

% add step with load
M='*STEP,NAME=STEP-1,AMPLITUDE=STEP,UNSYMM=NO'; % quasi-static
dlmwrite(filename_out, M, 'delimiter', '','-append');
M='*Coupled Thermal-Electrical, steady state, deltmx=0.';
dlmwrite(filename_out, M, 'delimiter', '','-append')
M='1., 1., 1e-05, 1.,  ';
dlmwrite(filename_out, M, 'delimiter', '','-append')

M='*SOLUTION TECHNIQUE,TYPE=SEPARATED';
dlmwrite(filename_out, M, 'delimiter', '','-append')
M='*Dsecurrent';
dlmwrite(filename_out, M, 'delimiter', '','-append')
M=[' SSURF, CS, ' num2str(currden)]; % injecting current
dlmwrite(filename_out, M, 'delimiter', '','-append')
M='*Restart, write, frequency=0';
dlmwrite(filename_out, M, 'delimiter', '','-append')
M='*Output, field, frequency=99999';
dlmwrite(filename_out, M, 'delimiter', '','-append')
M='*Node Output';
dlmwrite(filename_out, M, 'delimiter', '','-append')
M='COORD,';
dlmwrite(filename_out, M, 'delimiter', '','-append')
M='*Element Output, directions=YES';
dlmwrite(filename_out, M, 'delimiter', '','-append')
M='EPG,'; % output EPG (electric potential gradient, i.e., electric field)
dlmwrite(filename_out, M, 'delimiter', '','-append')
M='*Output, history, variable=PRESELECT';
dlmwrite(filename_out, M, 'delimiter', '','-append')
M='*END STEP';
dlmwrite(filename_out, M, 'delimiter', '','-append')

fprintf('Abaqus input file has been generated...\n');

% STEP 5: call Abaqus to solve the model
% system(['abaqus job=' filename_out ' scratch=./scratch memory="80 %"'])
% you can specify how many CPU cores can be used for the computation

%fprintf('waiting until solution completes...\n');
%fprintf('Check abaqus log file for completion of analysis...\n');
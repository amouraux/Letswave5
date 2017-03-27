function varargout = GLW_fieldtrip_dipfit_deletedipoles(varargin)
% GLW_FIELDTRIP_DIPFIT_DELETEDIPOLES MATLAB code for GLW_fieldtrip_dipfit_deletedipoles.fig
%
% Author : 
% Andr� Mouraux
% Institute of Neurosciences (IONS)
% Universit� catholique de louvain (UCL)
% Belgium
% 
% Contact : andre.mouraux@uclouvain.be
% This function is part of Letswave 5
% See http://nocions.webnode.com/letswave for additional information
%




% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GLW_fieldtrip_dipfit_deletedipoles_OpeningFcn, ...
                   'gui_OutputFcn',  @GLW_fieldtrip_dipfit_deletedipoles_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT




% --- Executes just before GLW_fieldtrip_dipfit_deletedipoles is made visible.
function GLW_fieldtrip_dipfit_deletedipoles_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GLW_fieldtrip_dipfit_deletedipoles (see VARARGIN)
% Choose default command line output for GLW_fieldtrip_dipfit_deletedipoles
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
%output
set(handles.processbutton,'Userdata',varargin{3});
axis off;
%fill listbox with inputfiles
set(handles.filebox,'String',varargin{2});




% --- Outputs from this function are returned to the command line.
function varargout = GLW_fieldtrip_dipfit_deletedipoles_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure




% --- Executes during object creation, after setting all properties.
function figure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called




% --- Executes on selection change in filebox.
function filebox_Callback(hObject, eventdata, handles)
% hObject    handle to filebox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes during object creation, after setting all properties.
function filebox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filebox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in processbutton.
function processbutton_Callback(hObject, eventdata, handles)
% hObject    handle to processbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
inputfiles=get(handles.filebox,'String');
update_status=get(handles.processbutton,'UserData');
update_status.function(update_status.handles,'*** DIPFIT : delete dipoles.',1,0);
%loop through files
for filepos=1:length(inputfiles);
    header=LW_load_header(inputfiles{filepos});
    %delete dipole solutions if present
    if isfield(header,'fieldtrip_dipfit');
        if isfield(header.fieldtrip_dipfit,'dipole');
            header.fieldtrip_dipfit=rmfield(header.fieldtrip_dipfit,'dipole');
            update_status.function(update_status.handles,'Dipole solutions were found, deleting all dipoles.',1,0);
        else
            update_status.function(update_status.handles,'No dipole solutions were found, skipping.',1,0);
        end;
    else
        update_status.function(update_status.handles,'No fieldtrip_dipfit header was found, skipping.',1,0);
    end;
    LW_save_header(inputfiles{filepos},[],header);
end;
update_status.function(update_status.handles,'Finished!',0,1);

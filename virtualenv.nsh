
Var VIRTUALENV_EXITCODE
Var VIRTUALENVVIRTUALENV_PYTHONEXE 

!macro PythonVenv PYTHONVERSION VENVPATH
  nsExec::ExecToLog 'py -${PYTHONVERSION}'
  Pop $VIRTUALENV_EXITCODE
  ${If} $VIRTUALENV_EXITCODE == 0
    DetailPrint "Python ${PYTHONVERSION} seems to be available"
  ${Else}
    MessageBox MB_OK "Python ${PYTHONVERSION} is not available quitting install"
    Quit
  ${EndIf}
  
  nsExec::ExecToLog 'py -${PYTHONVERSION} -m venv ${VENVPATH}'
  Pop $VIRTUALENV_EXITCODE
  ${If} $VIRTUALENV_EXITCODE == 0
    DetailPrint "Python virtual environment install at ${VENVPATH}"
  ${Else}
    MessageBox MB_OK "The Python virtual environment failed to install quitting install"
    Quit
  ${EndIf}
!macroend

!macro PythonInstallLocal VENVPATH PACKAGENAME LINKS 
  StrCpy $VIRTUALENV_PYTHONEXE "${VENVPATH}\Scripts\python.exe"
  nsExec::ExecToLog '$VIRTUALENV_PYTHONEXE -m pip install --no-index --find-links ${LINKS} ${PACKAGENAME}'
  Pop $VIRTUALENV_EXITCODE
  ${If} $VIRTUALENV_EXITCODE == 0
    DetailPrint "Packages successfully installed"
  ${Else}
    MessageBox MB_OK "Failed to install packages and dependencies"
  ${EndIf}
!macroend

!macro PythonInstallInternet VENVPATH PACKAGENAME
  StrCpy $VIRTUALENV_PYTHONEXE "${VENVPATH}\Scripts\python.exe"
  nsExec::ExecToLog '$VIRTUALENV_PYTHONEXE -m pip install ${PACKAGENAME}'
  Pop $VIRTUALENV_EXITCODE
  ${If} $VIRTUALENV_EXITCODE == 0
    DetailPrint "Packages successfully installed"
  ${Else}
    MessageBox MB_OK "Failed to install packages and dependencies"
  ${EndIf}
!macroend
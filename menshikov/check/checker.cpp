//
// Written by Fyodor Menshikov 31.12.2004-02.01.2005
//
// Compiled using free Borland C++ 5.5.1
//
// 20.01.2005 - now works on Windows XP
//

#include <fstream.h>
#include <iostream.h>
#include <string.stl>
#include <stdlib.h>
#include <windows.h>

const char BackSlash='\\';

string intToStr(int n){
   if(n<0){
      cout<<"Internal error: intToStr with negative argument"<<endl;
      exit(1);
   }
   string s="";
   do{
      int d=n%10;
      n=n/10;
      s=(char)(d+(int)'0')+s;
   }while(n>0);
   return s;
}

string upcase(string s){
   for(int i=0;i<s.length();i++){
      if('a'<=s[i]&&s[i]<='z'){
         s[i]=s[i]-'a'+'A';
      }
   }
   return s;
}

ifstream ConfFile;
int ConfFileLineNo;
string ConfFileLine;
string ConfFileName;

void OpenConfFile(string name){
   ConfFileName=name;
   ConfFile.open(ConfFileName.c_str());
   if(ConfFile.fail()){
      cout<<"Error: cannot open "<<ConfFileName<<endl;
      exit(0);
   }
   ConfFileLineNo=1;
   getline(ConfFile,ConfFileLine,'\n');
}

void CloseConfFile(){
   ConfFile.close();
   if(ConfFile.fail()){
      cout<<"Error: cannot close "<<ConfFileName<<endl;
      exit(0);
   }
}

bool IsEndOfConfFile(){
   return ConfFile.eof();
}

void ConfFileBadDataFormat(){
   cout<<"Error in file "<<ConfFileName<<" line "<<(ConfFileLineNo-1)<<":"<<endl;
   cout<<"   wrong data format"<<endl;
   exit(0);
}

void ConfFileCheckEnd(){
   if(ConfFileLine!=""||!IsEndOfConfFile()){
      cout<<"Error in file "<<ConfFileName<<" line "<<ConfFileLineNo<<":"<<endl;
      cout<<"   end of file expected"<<endl;
      exit(0);
   }
}

void GetConfFileLine(string name,string &value){
   if(IsEndOfConfFile()){
      cout<<"Error in file "<<ConfFileName<<" line "<<ConfFileLineNo<<":"<<endl;
      cout<<"   parameter "<<name<<" expected"<<endl;
      exit(0);
   }
   if(ConfFileLine.find(name)!=0){
      cout<<"Error in file "<<ConfFileName<<" line "<<ConfFileLineNo<<":"<<endl;
      cout<<"   parameter "<<name<<" expected"<<endl;
      exit(0);
   }
   ConfFileLine=ConfFileLine.substr(name.length());
   if(ConfFileLine==""){
      value="";
   }else{
      if(ConfFileLine.find(" ")!=0){
         cout<<"Error in file "<<ConfFileName<<" line "<<ConfFileLineNo<<":"<<endl;
         cout<<"   parameter "<<name<<" expected"<<endl;
         exit(0);
      }
      value=ConfFileLine.substr(1);
   }
   ConfFileLineNo++;
   getline(ConfFile,ConfFileLine,'\n');
}

string ProgramPath;
string SubmittedName;
string ProblemId;
string LanguageId;

string SourceFileName;
string CompilationCommand;
string ExecutableFileName;
string ExecutionCommand;

void LoadLanguage(){
   string LangFileName=ProgramPath+"languages.conf";
   OpenConfFile(LangFileName);
   bool found=false;
   while(true){
      if(IsEndOfConfFile())
         break;
      string s;
      GetConfFileLine("Extension",s);
      bool now=(upcase(s)==upcase(LanguageId));
      if(now&&found){
         cout<<"Error: duplicate extension "<<upcase(LanguageId)<<" in "<<LangFileName<<endl;
         exit(0);
      }
      if(now)
         found=true;
      GetConfFileLine(".SourceFileName",s);
      if(now)
         SourceFileName=s;
      GetConfFileLine(".CompilationCommand",s);
      if(now)
         CompilationCommand=s;
      GetConfFileLine(".ExecutableFileName",s);
      if(now)
         ExecutableFileName=s;
      GetConfFileLine(".ExecutionCommand",s);
      if(now)
         ExecutionCommand=s;
   }
   CloseConfFile();
   if(!found){
      cout<<"Error: extension \""<<LanguageId<<"\" not found in "<<LangFileName<<endl;
      exit(0);
   }
}

string InputFilesPrefix;
string InputFilesPostfix;
string CheckFilesPrefix;
string CheckFilesPostfix;
string TestNumbers;
string ProgramInputFileName;
string ProgramOutputFileName;
string CheckerInputFileName;
string CheckerOutputFileName;
string CheckFileName;
string CheckProgram;
string TimeLimitOkProgram;
int ExtraTimeLimitPercent;
string TimeLimitExceededProgram;

int PercentStrToInt(string s,bool &BadFormat){
   BadFormat=true;
   if(s=="")
      return 0;
   if(s=="*"){
      BadFormat=false;
      return 0;
   }
   int n=0;
   for(int i=0;i<s.length();i++){
      if('0'<=s[i]&&s[i]<='9')
         n=n*10+(s[i]-'0');
      else
         return 0;
      if(n>=1000)
         return 0;
   }
   if(n==0)
      return 0;
   BadFormat=false;
   return n;
}

void LoadProblem(){
   string ProblemsFileName=ProgramPath+"problems.conf";
   OpenConfFile(ProblemsFileName);
   bool found=false;
   while(true){
      if(IsEndOfConfFile())
         break;
      string s;
      GetConfFileLine("Problem",s);
      bool now=(upcase(s)==upcase(ProblemId));
      if(now&&found){
         cout<<"Error: duplicate problem id "<<upcase(ProblemId)<<" in "<<ProblemsFileName<<endl;
         exit(0);
      }
      if(now)
         found=true;
      GetConfFileLine(".InputFilesPrefix",s);
      if(now)
         InputFilesPrefix=s;
      GetConfFileLine(".InputFilesPostfix",s);
      if(now)
         InputFilesPostfix=s;
      GetConfFileLine(".CheckFilesPrefix",s);
      if(now)
         CheckFilesPrefix=s;
      GetConfFileLine(".CheckFilesPostfix",s);
      if(now)
         CheckFilesPostfix=s;
      GetConfFileLine(".TestNumbers",s);
      if(now){
         while(true){
            if(s==""){
               cout<<"Error: TestNumbers parameter is empty for problem "
                  <<ProblemId<<" in "<<ProgramPath+"problems.conf"<<endl;
               exit(0);
            }
            if(s[0]==' ')
               s=s.substr(1);
            else
               break;
         }
         TestNumbers=s+" ";
      }
      GetConfFileLine(".ProgramInputFileName",s);
      if(now)
         ProgramInputFileName=s;
      GetConfFileLine(".ProgramOutputFileName",s);
      if(now)
         ProgramOutputFileName=s;
      GetConfFileLine(".CheckerInputFileName",s);
      if(now)
         CheckerInputFileName=s;
      GetConfFileLine(".CheckerOutputFileName",s);
      if(now)
         CheckerOutputFileName=s;
      GetConfFileLine(".CheckFileName",s);
      if(now)
         CheckFileName=s;
      GetConfFileLine(".CheckProgram",s);
      if(now)
         CheckProgram=s;
      GetConfFileLine(".TimeLimitOkProgram",s);
      if(now)
         TimeLimitOkProgram=s;
      GetConfFileLine(".TimeLimitExceededProgram",s);
      if(now)
         TimeLimitExceededProgram=s;
      bool BadFormat=false;
      GetConfFileLine(".ExtraTimeLimitPercent",s);
      if(now)
         ExtraTimeLimitPercent=PercentStrToInt(s,BadFormat);
      if(BadFormat)
         ConfFileBadDataFormat();
   }
   CloseConfFile();
   if(!found){
      cout<<"Error: problem id \""<<ProblemId<<"\" not found in "<<ProblemsFileName<<endl;
      exit(0);
   }
}

int TimeLimitOk;
int TimeLimitExceeded;
int ActualTimeLimit;
bool TimeLimitLoaded;

const int BeginEndTimeLimit=1000;//ms   TP - 1000, Delphi - 100
const int CompilationTimeLimit=10000;
const int CheckTimeLimit=30000;

int TimeLimitStrToInt(string s,bool &BadFormat){
   BadFormat=true;
   if(s=="")
      return 0;
   int n=0;
   for(int i=0;i<s.length();i++){
      if('0'<=s[i]&&s[i]<='9')
         n=n*10+(s[i]-'0');
      else
         return 0;
      if(n>1000000)
         return 0;
   }
   BadFormat=false;
   return n;
}

void LoadTimeLimit(){
   string TimeLimitFileName=ProgramPath+"time_limit.conf";
   HANDLE f=CreateFile(
      TimeLimitFileName.c_str(),
      GENERIC_READ|GENERIC_WRITE,
      0,//no share
      NULL,//no security
      OPEN_ALWAYS,//whole call was for this attribute - create if not exists
      FILE_ATTRIBUTE_ARCHIVE,
      NULL//no template
   );
   CloseHandle(f);
   OpenConfFile(TimeLimitFileName);
   TimeLimitLoaded=false;
   while(true){
      if(IsEndOfConfFile())
         break;
      string s;
      GetConfFileLine("Problem",s);
      bool now=(upcase(s)==upcase(ProblemId));
      if(now&&TimeLimitLoaded){
         cout<<"Error: duplicate problem id "<<upcase(ProblemId)<<" in "<<TimeLimitFileName<<endl;
         exit(0);
      }
      if(now)
         TimeLimitLoaded=true;
      bool BadFormat=false;
      GetConfFileLine(".TimeLimitOk",s);
      if(now)
         TimeLimitOk=TimeLimitStrToInt(s,BadFormat);
      if(BadFormat)
         ConfFileBadDataFormat();
      GetConfFileLine(".TimeLimitExceeded",s);
      if(now)
         TimeLimitExceeded=TimeLimitStrToInt(s,BadFormat);
      if(BadFormat)
         ConfFileBadDataFormat();
      GetConfFileLine(".ActualTimeLimit",s);
      if(now)
         ActualTimeLimit=TimeLimitStrToInt(s,BadFormat);
      if(BadFormat)
         ConfFileBadDataFormat();
   }
   CloseConfFile();
}

string OldDirectory;
string SourceDirectory;
string RunDirectory;
string Counter;

void LoadDirectories(){
   string DirectoriesFileName=ProgramPath+"directories.conf";
   OpenConfFile(DirectoriesFileName);
   GetConfFileLine("SourceDirectory",SourceDirectory);
   GetConfFileLine("RunDirectory",RunDirectory);
   ConfFileCheckEnd();
   CloseConfFile();
   if(SourceDirectory[SourceDirectory.length()-1]!=BackSlash){
      SourceDirectory+=BackSlash;
   }
   if(RunDirectory[RunDirectory.length()-1]!=BackSlash){
      RunDirectory+=BackSlash;
   }
   char OldPath[MAX_PATH];
   if(!GetCurrentDirectory(sizeof(OldPath),OldPath)){
      cout<<"Internal error: cannot get current directory"<<endl;
      exit(1);
   }
   OldDirectory=OldPath;
   if(!SetCurrentDirectory(SourceDirectory.c_str())){
      cout<<"Error: directory \""<<SourceDirectory<<"\" does not exist. "
         <<"Check parameter SourceDirectory in "<<DirectoriesFileName<<endl;
      exit(0);
   }
   if(!SetCurrentDirectory(RunDirectory.c_str())){
      cout<<"Error: directory \""<<RunDirectory<<"\" does not exist. "
         <<"Check parameter RunDirectory in "<<DirectoriesFileName<<endl;
      exit(0);
   }
   if(!SetCurrentDirectory(OldDirectory.c_str())){
      cout<<"Internal error: cannot get back to current directory"<<endl;
      exit(1);
   }
   ifstream fcnt;
   fcnt.open((SourceDirectory+"counter.txt").c_str());
   if(fcnt.fail()){
      cout<<"Error: cannot open "<<(SourceDirectory+"counter.txt")<<endl;
      exit(0);
   }
   getline(fcnt,Counter,'\n');
   fcnt.close();
   if(fcnt==""){
      cout<<"Error: first line of "<<(SourceDirectory+"counter.txt")<<" is empty"<<endl;
      exit(0);
   }
   for(int i=0;i<Counter.length();i++){
      if(Counter[i]<'0'||Counter[i]>'9'){
         cout<<"Error: first line of "<<(SourceDirectory+"counter.txt")<<" contains non-digit"<<endl;
         exit(0);
      }
   }
}

void AppendTimeLimits(int Ok,int Exceeded,int Actual){
   HANDLE h=CreateFile(
      (ProgramPath+"time_limit.conf").c_str(),
      GENERIC_WRITE,
      0,//no share
      NULL,//no security
      OPEN_EXISTING,
      0,//we do not create file
      NULL//no template
   );
   if(h==INVALID_HANDLE_VALUE){
      cout<<"Internal error: cannot open "<<(ProgramPath+"time_limit.conf")<<endl;
      exit(1);
   }
   if(SetFilePointer(
      h,
      0,
      NULL,
      FILE_END
   )==-1){
      cout<<"Internal error: cannot set pointer to end of file "<<(ProgramPath+"time_limit.conf")<<endl;
      exit(1);
   }
   char buffer[1024];
   strcpy(buffer,("Problem "+ProblemId+"\x0D\x0A.TimeLimitOk "+intToStr(Ok)+"\x0D\x0A.TimeLimitExceeded "+intToStr(Exceeded)+"\x0D\x0A.ActualTimeLimit "+intToStr(Actual)+"\x0D\x0A").c_str());
   DWORD written;
   if(!WriteFile(
      h,
      buffer,
      strlen(buffer),
      &written,
      NULL
   )){
      cout<<"Internal error: cannot write to "<<(ProgramPath+"time_limit.conf")<<endl;
      exit(1);
   }
   if(!CloseHandle(h)){
      cout<<"Internal error: cannot close "<<(ProgramPath+"time_limit.conf")<<endl;
      exit(1);
   }
}

int GetProgTimeLimit(string ProgramName,string TestNums){
   cout<<" Tests:";
   int TimeLimit=-1;
   while(true){
      while(TestNums!=""&&TestNums[0]==' ')
         TestNums=TestNums.substr(1);
      if(TestNums=="")
         return TimeLimit;
      int sp=TestNums.find(' ');
      if(sp<=0){
         cout<<"Internal error: space absent in TestNumbers"<<endl;
         exit(1);
      }
      string TestId=TestNums.substr(0,sp);
      TestNums=TestNums.substr(sp);
      cout<<" "<<TestId;
      if(!CopyFile(
         (InputFilesPrefix+TestId+InputFilesPostfix).c_str(),
         (RunDirectory+ProgramInputFileName).c_str(),
         FALSE//overwrite
      )){
         cout<<"Error: cannot copy "<<InputFilesPrefix+TestId+InputFilesPostfix
            <<" to "<<RunDirectory+ProgramInputFileName<<endl;
         exit(0);
      }
      STARTUPINFO si;
      si.cb=sizeof(si);
      si.lpReserved=NULL;
      si.lpDesktop=NULL;
      si.lpTitle=NULL;
      si.dwFlags=STARTF_USESHOWWINDOW;
      si.wShowWindow=SW_MINIMIZE|SW_HIDE;
      si.cbReserved2=0;
      si.lpReserved2=NULL;
      PROCESS_INFORMATION pi;
      DWORD StartTime=GetTickCount();
      if(!CreateProcess(
         ProgramName.c_str(),
         NULL,//command line is application name
         NULL,//no security
         NULL,//no security
         FALSE,//do not inherit handles
         CREATE_NEW_CONSOLE,
         NULL,//no separate environment
         RunDirectory.c_str(),
         &si,
         &pi
      )){
         cout<<"Error: cannot run \""<<ProgramName<<"\""<<endl;
         exit(0);
      }
      if(WaitForSingleObject(pi.hProcess,30000)==WAIT_TIMEOUT){
         cout<<"Error: "<<ProgramName<<" hangs"<<endl;
         exit(0);
      }
      DWORD StopTime=GetTickCount();
      int RunTime=StopTime-StartTime;
      if(RunTime>TimeLimit){
         TimeLimit=RunTime;
      }
   }
}

void CreateTimeLimit(){
   if(TimeLimitLoaded)
      return;
   if(TimeLimitOkProgram=="*"){
      AppendTimeLimits(0,0,BeginEndTimeLimit);
      LoadTimeLimit();
      return;
   }
   cout<<"Calculating time limit..."<<endl;
   //TimeLimitOkProgram!="*"
   cout<<"Good program...";
   TimeLimitOk=GetProgTimeLimit(TimeLimitOkProgram,TestNumbers);
   cout<<" Done"<<endl;
   if(TimeLimitExceededProgram=="*"){
      /*if(TimeLimitOk==0)
         ActualTimeLimit=BeginEndTimeLimit;
      else if(TimeLimitExceeded==0)
         ActualTimeLimit=TimeLimitOk*2;
      else
         ActualTimeLimit=(TimeLimitOk+TimeLimitExceeded)/2;
      return;*/
      AppendTimeLimits(TimeLimitOk,0,TimeLimitOk*(100+ExtraTimeLimitPercent)/100);
      LoadTimeLimit();
      return;
   }
   //TimeLimitExceededProgram!="*"
   cout<<"Bad program...";
   TimeLimitExceeded=GetProgTimeLimit(TimeLimitExceededProgram,TestNumbers);
   cout<<" Done"<<endl;
   AppendTimeLimits(TimeLimitOk,TimeLimitExceeded,(TimeLimitOk+TimeLimitExceeded)/2);
   LoadTimeLimit();
}

void IncCounter(){
   for(int i=Counter.length()-1;i>=0;i--){
      if(Counter[i]!='9'){
         Counter[i]+=1;
         return;
      }else{
         Counter[i]='0';
      }
   }
   Counter='1'+Counter;
}

void StoreCounter(){
   ofstream fcnt;
   fcnt.open((SourceDirectory+"counter.txt").c_str());
   if(fcnt.fail()){
      cout<<"Error: cannot open "<<(SourceDirectory+"counter.txt")<<" to write"<<endl;
      exit(0);
   }
   fcnt<<Counter;
   fcnt.close();
}

void DeleteFileOrDie(string filename){
   HANDLE h=CreateFile(
      filename.c_str(),
      GENERIC_WRITE,
      0,//no share
      NULL,//no security
      CREATE_ALWAYS,//overwrite if exists
      0,//no attributes
      NULL//no template
   );
   if(h==INVALID_HANDLE_VALUE){
      cout<<"Error: cannot create or overwrite "<<filename<<endl;
      exit(0);
   }
   if(!CloseHandle(h)){
      cout<<"Error: cannot close handle of "<<filename<<endl;
      exit(0);
   }
   if(!DeleteFile(filename.c_str())){
      cout<<"Error: cannot delete "<<filename<<endl;
      exit(0);
   }
}

bool CannotReadFile(string filename){
   HANDLE h=CreateFile(
      filename.c_str(),
      GENERIC_READ,
      0,//no share
      NULL,//no security
      OPEN_EXISTING,//overwrite if exists
      0,//no attributes
      NULL//no template
   );
   if(h==INVALID_HANDLE_VALUE)
      return true;
   if(!CloseHandle(h))
      return true;
   return false;
}

DWORD NeedProcessId;
HWND FoundWindowHandle;

BOOL CALLBACK EnumWindowsProc(HWND hwnd,LPARAM lparam){
   DWORD pid;
   GetWindowThreadProcessId(hwnd,&pid);
   if(pid==NeedProcessId)
      FoundWindowHandle=hwnd;
   return TRUE;
}

void Answer(string msg){
   cout<<endl<<msg<<endl;
   exit(0);
}

void Testing(){
   IncCounter();
   StoreCounter();
   if(!CopyFile(
      SubmittedName.c_str(),
      (SourceDirectory+Counter+"_"+SubmittedName).c_str(),
      TRUE//not overwrite
   )){
      cout<<"Error: cannot copy "<<SubmittedName<<" to "
         <<(SourceDirectory+Counter+"_"+SubmittedName)<<endl;
      exit(0);
   }
   if(!CopyFile(
      (SourceDirectory+Counter+"_"+SubmittedName).c_str(),
      (RunDirectory+SourceFileName).c_str(),
      FALSE//do overwrite
   )){
      cout<<"Error: cannot copy "<<(SourceDirectory+Counter+"_"+SubmittedName)
         <<" to "<<(RunDirectory+SourceFileName)<<endl;
      exit(0);
   }
   DeleteFileOrDie(RunDirectory+ExecutableFileName);
   SECURITY_ATTRIBUTES sa;
   sa.nLength=sizeof(sa);
   sa.lpSecurityDescriptor=NULL;
   sa.bInheritHandle=TRUE;
   HANDLE hStdOutput=CreateFile(
      (RunDirectory+".stdout").c_str(),
      GENERIC_WRITE,
      0,//no share
      &sa,//can be inherited
      CREATE_ALWAYS,//overwrite if exists
      0,//no attributes
      NULL//no template
   );
   if(hStdOutput==INVALID_HANDLE_VALUE){
      cout<<"Error: cannot create file "<<(RunDirectory+".stdout")<<endl;
      exit(0);
   }
   STARTUPINFO si;
   si.cb=sizeof(si);
   si.lpReserved=NULL;
   si.lpDesktop=NULL;
   si.lpTitle=NULL;
   si.dwFlags=STARTF_USESHOWWINDOW|STARTF_USESTDHANDLES;
   si.wShowWindow=SW_MINIMIZE|SW_HIDE;
   si.cbReserved2=0;
   si.lpReserved2=NULL;
   si.hStdInput=NULL;
   si.hStdOutput=hStdOutput;
   si.hStdError=hStdOutput;
   //
   // Output must be redirected because
   // Win95/98 does not close MS-DOS window with any text printed
   // - it waits for user to see the text and close the window
   //
   PROCESS_INFORMATION pi;
   if(!CreateProcess(
      NULL,//application name in command line
      (char*)CompilationCommand.c_str(),
      NULL,//no security
      NULL,//no security
      TRUE,//do inherit handles
      CREATE_NEW_CONSOLE,
      NULL,//same environment
      RunDirectory.c_str(),
      &si,
      &pi
   )){
      cout<<"Error: cannot run "<<CompilationCommand<<endl;
      exit(0);
   }
   if(
      WaitForSingleObject(
         pi.hProcess,
         CompilationTimeLimit
      )==WAIT_TIMEOUT
   ){
      cout<<"Error: "<<CompilationCommand<<" hangs"<<endl;
      exit(0);
   }
   if(!CloseHandle(hStdOutput)){
      cout<<"Error: cannot close "<<(RunDirectory+".stdout")<<endl;
      exit(0);
   }
   if(CannotReadFile(RunDirectory+ExecutableFileName))
      Answer("Compilation error");

   cout<<"Tests:";
   while(true){
      while(TestNumbers!=""&&TestNumbers[0]==' ')
         TestNumbers=TestNumbers.substr(1);
      if(TestNumbers==""){
         cout<<endl;
         DeleteFile((RunDirectory+ProgramInputFileName).c_str());
         DeleteFile((RunDirectory+ProgramOutputFileName).c_str());
         DeleteFile((RunDirectory+CheckerInputFileName).c_str());
         DeleteFile((RunDirectory+CheckerOutputFileName).c_str());
         DeleteFile((RunDirectory+CheckFileName).c_str());
         DeleteFile((RunDirectory+SourceFileName).c_str());
         DeleteFile((RunDirectory+ExecutableFileName).c_str());
         DeleteFile((RunDirectory+".stdout").c_str());
         Answer("*** Accepted ***");
      }
      int sp=TestNumbers.find(' ');
      if(sp<=0){
         cout<<"Internal error: space absent in TestNumbers"<<endl;
         exit(1);
      }
      string TestId=TestNumbers.substr(0,sp);
      TestNumbers=TestNumbers.substr(sp);
      cout<<" "<<TestId;

      if(!CopyFile(
         (InputFilesPrefix+TestId+InputFilesPostfix).c_str(),
         (RunDirectory+ProgramInputFileName).c_str(),
         FALSE//do overwrite
      )){
         cout<<"Error: cannot copy "
            <<(InputFilesPrefix+TestId+InputFilesPostfix)
            <<" to "<<(RunDirectory+ProgramInputFileName)<<endl;
         exit(0);
      }
      DeleteFileOrDie(RunDirectory+ProgramOutputFileName);

      si.cb=sizeof(si);
      si.lpReserved=NULL;
      si.lpDesktop=NULL;
      si.lpTitle=NULL;
      si.dwFlags=STARTF_USESHOWWINDOW;
      si.wShowWindow=SW_MINIMIZE|SW_HIDE;
      si.cbReserved2=0;
      si.lpReserved2=NULL;
      //
      // Output: redirect or not redirect?
      //
      // redirect:
      // Win95/98 does not close MS-DOS window with any text printed
      // - it waits for user to see the text and close the window
      //
      // When runtime error occurs, text is printed
      // To find the difference between runtime error and time limit
      // window should be closed
      //
      // not redirect:
      // Win95/98 refuses to do TerminateProcess when output is redirected
      //
      // Solution:
      // Window is closed when it is specified in pif-file.
      // So if pif file is in the folder, all works like on WinNT
      // All we need is to place pif file into folder before checker start
      //
      UINT OldErrorMode=SetErrorMode(SEM_NOGPFAULTERRORBOX);
      SetCurrentDirectory(RunDirectory.c_str());
      if(!CreateProcess(
         NULL,//application name in command line
         (char*)ExecutionCommand.c_str(),
         NULL,//no security
         NULL,//no security
         FALSE,//do not inherit handles
         CREATE_NEW_CONSOLE,
         NULL,//same environment
         RunDirectory.c_str(),
         &si,
         &pi
      )){
         SetCurrentDirectory(OldDirectory.c_str());
         cout<<"Error: cannot run "<<ExecutionCommand<<endl;
         exit(0);
      }
      SetCurrentDirectory(OldDirectory.c_str());
      SetErrorMode(OldErrorMode);
      if(
         WaitForSingleObject(
            pi.hProcess,
            ActualTimeLimit
         )==WAIT_TIMEOUT
      ){
         if(!TerminateProcess(pi.hProcess,0)){
            cout<<"Error: cannot terminate process"<<endl;
            exit(0);
         }
         Answer("Time limit exceeded");
      }
      
      DWORD ec;
      if(!GetExitCodeProcess(
         pi.hProcess,
         &ec
      )){
         cout<<"Internal error: cannot get exit code"<<endl;
         exit(1);
      }
      if(ec!=0)
         Answer("Runtime error");

      if(CannotReadFile(RunDirectory+ProgramOutputFileName))
         Answer("Output file absent");

      DeleteFileOrDie(RunDirectory+ProgramInputFileName);

      if(CheckerInputFileName!="*"){
         if(!CopyFile(
            (InputFilesPrefix+TestId+InputFilesPostfix).c_str(),
            (RunDirectory+CheckerInputFileName).c_str(),
            FALSE//do overwrite
         )){
            cout<<"Error: cannot copy "
               <<(InputFilesPrefix+TestId+InputFilesPostfix)
               <<" to "<<(RunDirectory+CheckerInputFileName)<<endl;
            exit(0);
         }
      }
      if(ProgramOutputFileName!=CheckerOutputFileName){
         //actually "!=" is not absolutely good here
         // - one file may be referenced by different names
         DeleteFileOrDie(RunDirectory+CheckerOutputFileName);
         if(!MoveFile(
            (RunDirectory+ProgramOutputFileName).c_str(),
            (RunDirectory+CheckerOutputFileName).c_str()
         )){
            cout<<"Error: cannot move "
               <<(RunDirectory+ProgramOutputFileName)
               <<" to "<<(RunDirectory+CheckerOutputFileName)<<endl;
            exit(0);
         }
      }
      if(CheckFileName!="*"){
         if(!CopyFile(
            (CheckFilesPrefix+TestId+CheckFilesPostfix).c_str(),
            (RunDirectory+CheckFileName).c_str(),
            FALSE//do overwrite
         )){
            cout<<"Error: cannot copy "
               <<(CheckFilesPrefix+TestId+CheckFilesPostfix)
               <<" to "<<(RunDirectory+CheckFileName)<<endl;
            exit(0);
         }
      }

      hStdOutput=CreateFile(
         (RunDirectory+".stdout").c_str(),
         GENERIC_WRITE,
         0,//no share
         &sa,//can be inherited
         CREATE_ALWAYS,//overwrite if exists
         0,//no attributes
         NULL//no template
      );
      if(hStdOutput==INVALID_HANDLE_VALUE){
         cout<<"Error: cannot create file "<<(RunDirectory+".stdout")<<endl;
         exit(0);
      }
      si.cb=sizeof(si);
      si.lpReserved=NULL;
      si.lpDesktop=NULL;
      si.lpTitle=NULL;
      si.dwFlags=STARTF_USESHOWWINDOW|STARTF_USESTDHANDLES;
      si.wShowWindow=SW_MINIMIZE|SW_HIDE;
      si.cbReserved2=0;
      si.lpReserved2=NULL;
      si.hStdInput=NULL;
      si.hStdOutput=hStdOutput;
      si.hStdError=hStdOutput;
      //
      // Output must be redirected because
      // Win95/98 does not close MS-DOS window with any text printed
      // - it waits for user to see the text and close the window
      //
      if(!CreateProcess(
         NULL,//application name in command line
         (char*)CheckProgram.c_str(),
         NULL,//no security
         NULL,//no security
         TRUE,//do inherit handles
         CREATE_NEW_CONSOLE,
         NULL,//same environment
         RunDirectory.c_str(),
         &si,
         &pi
      )){
         cout<<"Error: cannot run "<<CheckProgram<<endl;
         exit(0);
      }
      if(
         WaitForSingleObject(
            pi.hProcess,
            CheckTimeLimit
         )==WAIT_TIMEOUT
      ){
         cout<<"Error: "<<CheckProgram<<" hangs"<<endl;
         exit(0);
      }
      if(!CloseHandle(hStdOutput)){
         cout<<"Error: cannot close "<<(RunDirectory+".stdout")<<endl;
         exit(0);
      }
      if(!GetExitCodeProcess(
         pi.hProcess,
         &ec
      )){
         cout<<"Internal error: cannot get exit code"<<endl;
         exit(1);
      }
      if(ec==0){
         //Ok
      }else if(ec==1)
         Answer("Wrong answer");
      else{
         Answer("Presentation error");
      }
   }
}

void ShowUsage(){
   cout<<"Usage: checker filename.ext"<<endl;
   cout<<endl;
   cout<<"filename - identifier of problem, see in problems.conf"<<endl;
   cout<<"ext - language extension, see in languages.conf"<<endl;
   cout<<endl;
   cout<<"Example: checker primes.pas"<<endl;
   exit(0);
}

void ProcessArgs(int argc,char** argv){
   if(argc==1)
      ShowUsage();
   if(argc!=2){
      cout<<"Error: invalid number of parameters"<<endl;
      cout<<endl;
      ShowUsage();
   }
   //argc==2;
   string FirstParam=argv[1];
   if(FirstParam=="/?"||FirstParam=="-?"||FirstParam=="--help")
      ShowUsage();
   SubmittedName=FirstParam;
   HANDLE h=CreateFile(
      SubmittedName.c_str(),
      GENERIC_READ,
      0,//cannot be shared
      NULL,//no security
      OPEN_EXISTING,
      0,//file attributes not specified - we do not create
      NULL//no template file - we do not create
   );
   if(h==INVALID_HANDLE_VALUE){
      cout<<"Error: cannot open "<<SubmittedName<<endl;
      cout<<endl;
      ShowUsage();
   }
   CloseHandle(h);
   int PointPos=SubmittedName.rfind(".");
   if(PointPos==-1){
      cout<<"Error: point absent in filename \""<<SubmittedName<<"\""<<endl;
      cout<<endl;
      ShowUsage();
   }
   ProblemId=SubmittedName.substr(0,PointPos);
   LanguageId=SubmittedName.substr(PointPos+1);
   string ProgramName=argv[0];
   int SlashPos=ProgramName.rfind(BackSlash);
   if(SlashPos==-1){
      cout<<"Internal error: backslash absent in full program name \""<<ProgramName<<"\""<<endl;
      exit(1);
   }
   ProgramPath=ProgramName.substr(0,SlashPos+1);
}

int main(int argc, char** argv){
   ProcessArgs(argc,argv);
   LoadLanguage();
   LoadProblem();
   LoadTimeLimit();
   LoadDirectories();
   CreateTimeLimit();
   Testing();
}

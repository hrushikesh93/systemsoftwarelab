#include <stdio.h> 
struct proc  
{ int id;  
int arrival;  
int burst;  
int rem;  
int wait;  
int finish;  
 int turnaround;  
 float ratio;  
}process[10]; //structure to hold the process information struct  
proc temp;  
int no; int  
chkprocess(int); int  
nextprocess();  
main()  
{  
 int n,tq,choice; int  
bt[10],st[10],i,j,k;  
 printf("\n \n ---SHORTEST REMAINING TIME NEXT---\n \n ");  
printf("\n \n Enter the number of processes: "); scanf("%d",  
&n);  
 srtf(n);  
} 
int chkprocess(int s) // function to check process remaining time is zero or not  { int  
i;  
for(i = 1; i <= s; i++)  
{  
if(process[i].rem != 0) return  
1;  
}  
return 0;  
} // end of chkprocess int nextprocess() // function to identify the next  process to be executed  
{  
int min, l, i;  
min = 32000; //any limit assumed  
for(i = 1; i <= no; i++)  
{  
if( process[i].rem!=0 && process[i].rem < min)  
{  
min = process[i].rem;  
l = i; }  
}  
return l;  
} // end of nextprocess  
void srtf(int n)  
{  
int i,j,k,time=0; float  
tavg,wavg;  
for(i = 1; i <= n; i++) 
{  
process[i].id = i; printf("\n\nEnter the arrival time for  process %d: ",i); scanf("%d", &(process[i].arrival));  
printf("Enter the burst time for process %d: ", i);  
scanf("%d", &(process[i].burst)); process[i].rem =  
process[i].burst;  
}  
for(i = 1; i <= n; i++)  
{  
for(j = i + 1; j <= n; j++)  
{  
if(process[i].arrival > process[j].arrival) // sort arrival time of a process  {  
temp = process[i]; process[i]  
= process[j]; process[j] =  
temp;  
}  
}  
}  
no = 0;  
j = 1;  
while(chkprocess(n) == 1)  
{  
if(process[no + 1].arrival == time)  
{  
while(process[no+1].arrival==time) no++;  
 if(process[j].rem==0)  
process[j].finish=time; j =  
nextprocess(); 
}  
if(process[j].rem != 0) // to calculate the waiting time of a process  {  
process[j].rem--; for(i  
= 1; i <= no; i++)  
{  
if(i != j && process[i].rem != 0) process[i].wait++;  
}  
}  
else  
{  
process[j].finish = time;  
j=nextprocess(); time--;  
k=j;  
}  
time++;  
}  
process[k].finish = time; printf("\n\n\t\t\t---SHORTEST REMAINING TIME FIRST---");  printf("\n\n Process Arrival Burst Waiting Finishing turnaround Tr/Tb\n"); printf("%5s  %9s %7s %10s %8s%9s\n\n", "id", "time", "time", "time", "time", "time");  for(i = 1; i <= n; i++)  
{  
process[i].turnaround = process[i].wait + process[i].burst; // calc of turnaround  process[i].ratio = (float)process[i].turnaround /(float)process[i].burst; printf("%5d  %8d %7d %8d %10d %9d %10.1f ", process[i].id,  
process[i].arrival, process[i].burst, process[i].wait, process[i].finish,  process[i].turnaround, process[i].ratio); tavg=tavg+  
process[i].turnaround; //summation of turnaround time  
wavg=wavg+process[i].wait; // summation of waiting time 
printf("\n\n");  
}  
tavg=tavg/n; // average turnaround time wavg=wavg/n; // average wait time printf("tavg=%f\t  wavg=%f\n",tavg,wavg);  
}// end of srtf  



//---------------------------round robin-----------------------------------
#include <stdio.h>
#include <stdlib.h>
struct P
{
int pid,bt,tat,wt,at,ft;
}job[100];
void jobscheduler(struct P job[],int n,int q,int c)
{
int burst[100],k,t=0,done=0,current=0,diff=q,i=0;
float tat_sum=0,wt_sum=0;
for(i=0;i<n;i++)
burst[i]=job[i].bt;
if(c==0)
current=-1;
while(done<n)
{
if(c==1)
{
for(k=0;k<n;k++)
{
if(job[current].bt==0)
current=k;
if(job[k].bt<job[current].bt && job[k].bt>0 && job[k].at<=t)
current=k;
}

diff=1;
}
else
{
while(1)
{
current=(current+1)%n;
if(job[current].bt!=0)
break;
}
diff=(q<=job[current].bt)?q:job[current].bt;
}
job[current].bt-=diff;
t+=diff;
if(job[current].bt==0)
{
done++;
job[current].ft=t;
}
}
if(c==1)
printf("SRTF :\n");
else
printf("Round Robin :\n");
for(i=0;i<n;i++)
{
job[i].bt=burst[i];
job[i].tat=job[i].ft-job[i].at;
job[i].wt=job[i].tat-job[i].bt;
tat_sum+=job[i].tat;
wt_sum+=job[i].wt;
}
printf("PID\tBT\tAT\tTAT\tWT\n");
for(i=0;i<n;i++)
printf("%d\t%d\t%d\t%d\t%d\n",i+1,job[i].bt,job[i].at,job[i].tat,job[i].wt);
printf("Avg TAT=%f\nAvg WT=%f\n",tat_sum/n,wt_sum/n);
}
void main()
{
int n,q,c,i;
printf("Enter the number of processes :");
scanf("%d",&n);
printf("Enter the arrival time and burst time\n");
for(i=0;i<n;i++)
{
scanf("%d%d",&job[i].at,&job[i].bt);
}
while(1)

{
printf("1.Round Robin\n2.SRTF\n3.Exit\n");
scanf("%d",&c);
switch(c)
{
case 1:printf("Enter time quantum :");
scanf("%d",&q);
jobscheduler(job,n,q,0);
break;
case 2:jobscheduler(job,n,1,1);
break;
case 3:exit(0);
}
}
}

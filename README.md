

# smart contract development for student lifecycle on polygon
----------------------------------------------------------------------

This repo provides smart contracts for a PhD students lifecycle management. 
In the course of the PhD programme, a student takes multiple exams, seminers etc that are a bit different from a traditional undergrad student's experience. 

A student may typically appears for a qualifying exam, a SOTA seminer, comprehensive exams and final thesis defence. All these steps usually need the participation of multiple professors and approval of the student's guide(s). 

The smart contracts here implement a basic functionality where a student can seek approval from multiple professors, and get an event notified that all the requested professors have approved. 

What has been done?
1. v2.sol are v3.sol are buggy. The debugged versions of them are v4.sol and v5.sol respectively.
2. Two basic security features have been implemented, viz:
    * A teacher can't approve the same request twice
    * A basic process of registering students and professors.

To-Do:
1. The process of selection of extra professors for any exam has to be done by the student as well as the designated guide. Right now, the student directly does this. This has to be modified. 
2. Registration process has to be changed.
3. Contracts for other exams and functionalities have to be added.
    * 

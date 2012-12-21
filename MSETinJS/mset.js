/*
 * This is a JavaScript Scratchpad.
 *
 * Enter some JavaScript, then Right Click or choose from the Execute Menu:
 * 1. Run to evaluate the selected text (Cmd-R),
 * 2. Inspect to bring up an Object Inspector on the result (Cmd-I), or,
 * 3. Display to insert the result in a comment after the selection. (Cmd-L)
 */

document.getElementById('status').innerHTML = "hello world!"

/*  Here is an implementation of Elements for the MSET data type
*/


function Element(sym,vis,marker) {
    this.sym = sym;
    this.vis=vis;
    this.marker=marker;
    this.treeNode=null;
    this.nodeid=null;
    this.offset=null;
    this.listNode=null;
}


function createChar(c,n){
  var e = new Element(c,true,false);
  e.treeNode=n;
  e.nodeid=[n.user, n.count];
  e.offset = 0;
  return e;
}

function createStart(n){ 
  var startsym = "<"+n.user+":"+n.count;
  
  var e = new Element(startsym,false,true);
  e.treeNode = n;
  e.nodeid = [n.user, n.count];
  e.offset = "start";
  return e;
}

function createEnd(n){ 
  var endsym = n.user+":"+n.count+">";
  var e = new Element(endsym,false,true);
  e.treeNode = n;
  e.nodeid = [n.user, n.count];
  e.offset = "end";
  return e;
}



/* Here is an implementation of TreeNodes
*/
  
function Node(u,n) {
  this.user=u;
  this.count=n;
  this.elt=[];
  this.iset=[];
  this.iset[0]=[];
  }
  
function MSET(u){
  this.user = u;
  this.count = 0;
  this.size=0;
  this.root = new Node(0,0);
  this.strings = new DLL();
  this.nodes = [];
  this.nodes[[0,0]] = this.root;
  var n = this.strings.first;
  var e1,e2;
  e1 = createStart(this.root);
  e2 = createEnd(this.root);
  n = n.insertAfter(e1);
  n = n.insertAfter(e2);
  this.root.start = e1;
  this.root.end = e2;
}

  
  // var mset = new MSET(1);
  // mset.lookup([0,0],n00);
  

  
/* Create a node to in inserted in the mset tree given the nodeid and the character
* this requires creating the 3 corresponding elements and settingup the node.
*/
function createCharNode(nodeid,c){
  var n = new Node(nodeid[0],nodeid[1]);
  var e1 = createStart(n);
  var e2 = createChar(c,n);
  var e3 = createEnd(n);
  n.start   = e1;
  n.elt[0] = e2;
  n.end     = e3;
  n.iset[0] = [];
  n.iset[1] = [];
  return n;
}
  
function insertNode(m,s) {
  var i=0, n=s.length, k=-1;
  var u = m.user;
  while(i<n) {
    if (u< s[i].user) {
      s.splice(i,0,m);
      k=i;
      break;
      }
    else i = i+1;  
  }
  if (i==n) {s[n]=m; k=n;}
  //alert("insertnode:  k="+k+" s="+s+ " n="+n+" c="+m.elt[0].sym);
  return k;
}
  
function treeinsert(M,vm,q,un,c){
 //alert("treeinsert vm="+vm+" c="+c);
 var n = M.nodes[vm];
 var s = n.iset[q];
 var m = createCharNode(un,c);
 var e = m.elt[0];
 var f = n.start;
 var k = insertNode(m,s);

 // now we sew m into the doubly linked lists!!!
 if (k==0){
     if (q==0) {
        f=n.start;
     } else { // q>0
        f=n.elt[q-1];
     }
   } 
 else { // k>0
    f = s[k-1].end;
  }
 // next we insert the three new elements into the list
 f.listNode.insertAfter(m.start).insertAfter(m.elt[0]).insertAfter(m.end);
 // and insert the new node into the hashtable
 M.nodes[un]=m;
 M.size++;
 //alert("treeinsert q="+q+" c="+c);
 insertNode(m,s)
}

function treeextend(M,nodeid,c){
 var n = M.nodes[nodeid];
 var e = createChar(c,n);
 var d = n.elt.length;
 var f = n.end;
 e.offset = d;
 n.elt[d]=e;
 n.iset[d+1]=[];
 f.listNode.insertBefore(e);
 M.size++;
}

function treehide(M,nodeid,q) {
 var n = M.nodes[nodeid];
 var e = n.elt[q];
 e.vis=false;
 e.sym = "["+e.sym+"]";
}


//   var ch = document.getElementById('char').value;



/********************************************************
* Here is an implementation of doubly linked lists
*/
function ListNode(v){
     this.prev = null,
     this.next =null,
     this.val = v;
     this.insertBefore = function(a){
      var x = new ListNode(a);
      a.listNode = x;
      var tmp = this.prev;
      this.prev=x;
      x.next = this;
      x.prev = tmp;
      x.prev.next = x;
      return x;
      }
     this.insertAfter = function(a){
      var x = new ListNode(a);
      var tmp = this.next;
      this.next=x;
      x.prev = this;
      x.next = tmp;
      x.next.prev = x;
      a.listNode=x;
      return x;
      }
      
}

function DLL() {
  this.first = new ListNode("startmarker");
  this.last = new ListNode("endmarker");
  this.first.nodeid=-1;
  this.last.nodeid=-1;
  this.first.next = this.last;
  this.last.prev = this.first;
  this.printList = function(vis) {
    var d,s;
    
    s="";
    for(d = this.first.next; d != this.last; d=d.next) {
     if ( ((vis=="std") && d.val.vis) ||
          ((vis=="rev") && !(d.val.marker)) ||
          (vis=="edit") || (vis==undefined) )
        s = s + " " + d.val.sym;
    }
    return "[ "+s+" ]";
    }
  this.toString = this.printList;
  this.nth = function(n,vis) {
    var k=this.first.next;
    while ((n>0 || !k.val.vis)  && (k!= this.last) ) {
      console.log("n="+n+" k.sym="+k.val.sym);
      //alert("mset "+n+", "+k.val.sym.toString());
      if ( ((vis=="std") && k.val.vis) ||
          ((vis=="rev") && !(k.val.marker)) ||
          (vis=="edit") || (vis==undefined) )
          n = n-1;
      k=k.next;}
      //alert("mset return="+k.val.sym);
    return k;
    }
  this.nextNonMarker = function(e) {
    while ((e!== null) && e.val.marker){
        console.log("nextnonmarker e.val.sym="+e.val.sym);
        e=e.next;
     }
    return e;
   }
    
  }
  
  
/********************
* Here is some testing stuff....
*/
  x = new DLL();
  var y = x.first.insertAfter(createStart({user:0, count:0}))
  var c = createChar("c",{id:"v"});
  c.vis = false;
  y = y.insertAfter(c);
  y = y.insertAfter(createEnd({user:0, count:0}));
  //x.last.insertBefore(1).insertBefore(2).insertBefore(3);
  //y = x.last;
  //z = x.printList("rev");

  mset.strings.first.next.insertAfter(c);
   // z = mset.strings.printList("edit"); 
   

function stringdelete(M,k) {
  var e = M.strings.nth(k,"std").val;
  e.vis=false;
  e.sym = "["+e.sym+"]";
}

function stringinsert(M,k,c) {
    //alert("stringinsert k = "+k);
  if (k==0) {     // insert before the first non-marker character
    un = [M.user,M.count++];
    if (M.size==0) {// first insert into the empty tree
      treeinsert(M,[0,0],0,un,c);
    }
    else {
      //alert("M.size="+M.size);
      var e = M.strings.nth(0,"rev").val;
      //alert("stringinsert e="+e);
      console.log("zz "+e.nodeid.toString()+" un="+un.toString() + "c="+c);
      treeinsert(M,e.nodeid,0,un,c);
     }
    }
  else {
    // get the visible, non-marker elt e at position k-1
    //alert("stringinsert2 k = "+k);
    var ecell=M.strings.nth(k-1,"std");
    console.log("ecell.val.nodeid="+ecell.val.nodeid+"ecell.val.offsert="+ecell.val.offset
       +"sym="+ecell.val.sym);
    //alert("k-1 = ");
    //alert(k-1);
    //alert("e.val="+e.val);
    var fcell=ecell.next;
    if (!fcell.val.marker) {
    // if the next elt is a non-marker insert there
      //alert("f.sym="+f.sym);
      //console.log("f=end test="+f==M.strings.last);
      console.log("non-marker stringinsert f.nodeid="+fcell.val.sym.toString());
      console.log("f.val.nodeid="+fcell.val.nodeid+"fcell.val.offsert="
           +fcell.val.offset+"sym="+fcell.val.sym);
      treeinsert(M,fcell.val.nodeid,fcell.val.offset,[M.user,M.count++],c);
    } else if (fcell.val.marker && (fcell.val == fcell.val.treeNode.end)) {
    // if the next elt is an end-marker insert or extend there
      if (fcell.val.treeNode.user==M.user) {
        treeextend(M,fcell.val.nodeid,c);
        }
      else {
        console.log("insert at end, fcell.val.user="+fcell.val.user+" M.user="+M.user);
        treeinsert(M,fcell.val.nodeid,fcell.val.treeNode.elt.length,[M.user,M.count++],c);
        }
    } else {
    // if the next elt is a start marker, find the next non-marker f, insert before f
       console.log("lastcaseA fcell.val.sym="+fcell.val.sym);
       console.log("lastcaseA fcell.val.marker="+fcell.val.marker);
       console.log("lastcaseA fcell.val.sym="+fcell.val.treeNode.end.sym);
       console.log("lastcase fcell.val.nodeid="+fcell.val.nodeid.toString());
       fcell = M.strings.nextNonMarker(fcell);
       console.log("lastcase1 fcell.val="+fcell.val.toString());
       console.log("lastcase2 fcell.val.nodeid="+fcell.val.nodeid.toString());
       treeinsert(M,fcell.val.nodeid,0,[M.user,M.count++],c);
    }
  }
}

   
var mset; 

function initMSET(){
  mset = new MSET(1);
}
   
function applyop(op,q,c) {
/*
   treeinsert(mset,[0,0],0,[1,0],"A");
   treeinsert(mset,[0,0],0,[3,0],"B");
   treeinsert(mset,[0,0],0,[2,0],"C");
   treeinsert(mset,[1,0],1,[1,2],"D");
   treeextend(mset,[1,0],"E");
   treeextend(mset,[1,0],"F");
   treeinsert(mset,[1,0],2,[3,1],"G");
   treehide(mset,[1,0],0);
   treehide(mset,[1,0],1);
   treeinsert(mset,[3,1],1,[3,2],"H");
   treeinsert(mset,[3,1],1,[1,3],"I");
   stringdelete(mset,5);
   stringdelete(mset,1);
   */
   stringinsert(mset,0,'a');
   stringinsert(mset,1,'b');
   stringinsert(mset,2,'c');
   stringinsert(mset,1,'d');
   stringdelete(mset,1);
   stringinsert(mset,1,'e');
   stringdelete(mset,1);
   stringinsert(mset,1,'f');
   stringdelete(mset,3);
   stringinsert(mset,3,'g');
   document.getElementById('estring').innerHTML = mset.strings.printList('edit');
   document.getElementById('rstring').innerHTML = mset.strings.printList('rev');
   document.getElementById('sstring').innerHTML = mset.strings.printList('std');
   document.getElementById('status').innerHTML = "done!";
   //document.getElementById('status').innerHTML = "val =" + mset.nodes[[0,0]].user;
}


initMSET();
applyop(1,2,3);



/*
Exception: missing ) after argument list
@Scratchpad:302
*/
/*
Exception: missing ) after argument list
@Scratchpad:301
*/
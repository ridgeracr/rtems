@c
@c  COPYRIGHT (c) 1996.
@c  On-Line Applications Research Corporation (OAR).
@c  All rights reserved.
@c

@ifinfo
@node Partition Manager, Partition Manager Introduction, SIGNAL_SEND - Send signal set to a task, Top
@end ifinfo
@chapter Partition Manager
@ifinfo
@menu
* Partition Manager Introduction::
* Partition Manager Background::
* Partition Manager Operations::
* Partition Manager Directives::
@end menu
@end ifinfo

@ifinfo
@node Partition Manager Introduction, Partition Manager Background, Partition Manager, Partition Manager
@end ifinfo
@section Introduction

The partition manager provides facilities to
dynamically allocate memory in fixed-size units.  The directives
provided by the partition manager are:

@itemize @bullet
@item @code{partition_create} - Create a partition
@item @code{partition_ident} - Get ID of a partition
@item @code{partition_delete} - Delete a partition
@item @code{partition_get_buffer} - Get buffer from a partition
@item @code{partition_return_buffer} - Return buffer to a partition
@end itemize

@ifinfo
@node Partition Manager Background, Partition Manager Definitions, Partition Manager Introduction, Partition Manager
@end ifinfo
@section Background
@ifinfo
@menu
* Partition Manager Definitions::
* Building a Partition's Attribute Set::
@end menu
@end ifinfo

@ifinfo
@node Partition Manager Definitions, Building a Partition's Attribute Set, Partition Manager Background, Partition Manager Background
@end ifinfo
@subsection Partition Manager Definitions

A partition is a physically contiguous memory area
divided into fixed-size buffers that can be dynamically
allocated and deallocated.

Partitions are managed and maintained as a list of
buffers.  Buffers are obtained from the front of the partition's
free buffer chain and returned to the rear of the same chain.
When a buffer is on the free buffer chain, RTEMS uses eight
bytes of each buffer as the free buffer chain.  When a buffer is
allocated, the entire buffer is available for application use.
Therefore, modifying memory that is outside of an allocated
buffer could destroy the free buffer chain or the contents of an
adjacent allocated buffer.

@ifinfo
@node Building a Partition's Attribute Set, Partition Manager Operations, Partition Manager Definitions, Partition Manager Background
@end ifinfo
@subsection Building a Partition's Attribute Set

In general, an attribute set is built by a bitwise OR
of the desired attribute components.  The set of valid partition
attributes is provided in the following table:

@itemize @bullet
@item LOCAL - local task (default)
@item GLOBAL - global task
@end itemize



Attribute values are specifically designed to be
mutually exclusive, therefore bitwise OR and addition operations
are equivalent as long as each attribute appears exactly once in
the component list.  An attribute listed as a default is not
required to appear in the attribute list, although it is a good
programming practice to specify default attributes.  If all
defaults are desired, the attribute DEFAULT_ATTRIBUTES should be
specified on this call.  The attribute_set parameter should be
GLOBAL to indicate that the partition is to be known globally.

@ifinfo
@node Partition Manager Operations, Creating a Partition, Building a Partition's Attribute Set, Partition Manager
@end ifinfo
@section Operations
@ifinfo
@menu
* Creating a Partition::
* Obtaining Partition IDs::
* Acquiring a Buffer::
* Releasing a Buffer::
* Deleting a Partition::
@end menu
@end ifinfo

@ifinfo
@node Creating a Partition, Obtaining Partition IDs, Partition Manager Operations, Partition Manager Operations
@end ifinfo
@subsection Creating a Partition

The partition_create directive creates a partition
with a user-specified name.  The partition's name, starting
address, length and buffer size are all specified to the
partition_create directive.  RTEMS allocates a Partition Control
Block (PTCB) from the PTCB free list.  This data structure is
used by RTEMS to manage the newly created partition.  The number
of buffers in the partition is calculated based upon the
specified partition length and buffer size, and returned to the
calling task along with a unique partition ID.

@ifinfo
@node Obtaining Partition IDs, Acquiring a Buffer, Creating a Partition, Partition Manager Operations
@end ifinfo
@subsection Obtaining Partition IDs

When a partition is created, RTEMS generates a unique
partition ID and assigned it to the created partition until it
is deleted.  The partition ID may be obtained by either of two
methods.  First, as the result of an invocation of the
partition_create directive, the partition ID is stored in a user
provided location.  Second, the partition ID may be obtained
later using the partition_ident directive.  The partition ID is
used by other partition manager directives to access this
partition.

@ifinfo
@node Acquiring a Buffer, Releasing a Buffer, Obtaining Partition IDs, Partition Manager Operations
@end ifinfo
@subsection Acquiring a Buffer

A buffer can be obtained by calling the
partition_get_buffer directive.  If a buffer is available, then
it is returned immediately with a successful return code.
Otherwise, an unsuccessful return code is returned immediately
to the caller.  Tasks cannot block to wait for a buffer to
become available.

@ifinfo
@node Releasing a Buffer, Deleting a Partition, Acquiring a Buffer, Partition Manager Operations
@end ifinfo
@subsection Releasing a Buffer

Buffers are returned to a partition's free buffer
chain with the partition_return_buffer directive.  This
directive returns an error status code if the returned buffer
was not previously allocated from this partition.

@ifinfo
@node Deleting a Partition, Partition Manager Directives, Releasing a Buffer, Partition Manager Operations
@end ifinfo
@subsection Deleting a Partition

The partition_delete directive allows a partition to
be removed and returned to RTEMS.  When a partition is deleted,
the PTCB for that partition is returned to the PTCB free list.
A partition with buffers still allocated cannot be deleted.  Any
task attempting to do so will be returned an error status code.

@ifinfo
@node Partition Manager Directives, PARTITION_CREATE - Create a partition, Deleting a Partition, Partition Manager
@end ifinfo
@section Directives
@ifinfo
@menu
* PARTITION_CREATE - Create a partition::
* PARTITION_IDENT - Get ID of a partition::
* PARTITION_DELETE - Delete a partition::
* PARTITION_GET_BUFFER - Get buffer from a partition::
* PARTITION_RETURN_BUFFER - Return buffer to a partition::
@end menu
@end ifinfo

This section details the partition manager's
directives.  A subsection is dedicated to each of this manager's
directives and describes the calling sequence, related
constants, usage, and status codes.

@page
@ifinfo
@node PARTITION_CREATE - Create a partition, PARTITION_IDENT - Get ID of a partition, Partition Manager Directives, Partition Manager Directives
@end ifinfo
@subsection PARTITION_CREATE - Create a partition

@subheading CALLING SEQUENCE:

@ifset is-C
@example
rtems_status_code rtems_partition_create(
  rtems_name        name,
  void             *starting_address,
  rtems_unsigned32  length,
  rtems_unsigned32  buffer_size,
  rtems_attribute   attribute_set,
  rtems_id         *id
);
@end example
@end ifset

@ifset is-Ada
@example
procedure Partition_Create (
   Name             : in     RTEMS.Name;
   Starting_Address : in     RTEMS.Address;
   Length           : in     RTEMS.Unsigned32;
   Buffer_Size      : in     RTEMS.Unsigned32;
   Attribute_Set    : in     RTEMS.Attribute;
   ID               :    out RTEMS.ID;
   Result           :    out RTEMS.Status_Codes
);
@end example
@end ifset

@subheading DIRECTIVE STATUS CODES:
@code{SUCCESSFUL} - partition created successfully@*
@code{INVALID_NAME} - invalid task name@*
@code{TOO_MANY} - too many partitions created@*
@code{INVALID_ADDRESS} - address not on four byte boundary@*
@code{INVALID_SIZE} - length or buffer size is 0@*
@code{INVALID_SIZE} - length is less than the buffer size@*
@code{INVALID_SIZE} - buffer size not a multiple of 4@*
@code{MP_NOT_CONFIGURED} - multiprocessing not configured@*
@code{TOO_MANY} - too many global objects

@subheading DESCRIPTION:

This directive creates a partition of fixed size
buffers from a physically contiguous memory space which starts
at starting_address and is length bytes in size.  Each allocated
buffer is to be of buffer_length in bytes.  The assigned
partition id is returned in id.  This partition id is used to
access the partition with other partition related directives.
For control and maintenance of the partition, RTEMS allocates a
PTCB from the local PTCB free pool and initializes it.

@subheading NOTES:

This directive will not cause the calling task to be
preempted.

The starting_address and buffer_size parameters must
be multiples of four.

Memory from the partition is not used by RTEMS to
store the Partition Control Block.

The following partition attribute constants are
defined by RTEMS:

@itemize @bullet
@item LOCAL - local task (default)
@item GLOBAL - global task
@end itemize

The PTCB for a global partition is allocated on the
local node.  The memory space used for the partition must reside
in shared memory. Partitions should not be made global unless
remote tasks must interact with the partition.  This is to avoid
the overhead incurred by the creation of a global partition.
When a global partition is created, the partition's name and id
must be transmitted to every node in the system for insertion in
the local copy of the global object table.

The total number of global objects, including
partitions, is limited by the maximum_global_objects field in
the Configuration Table.

@page
@ifinfo
@node PARTITION_IDENT - Get ID of a partition, PARTITION_DELETE - Delete a partition, PARTITION_CREATE - Create a partition, Partition Manager Directives
@end ifinfo
@subsection PARTITION_IDENT - Get ID of a partition

@subheading CALLING SEQUENCE:

@ifset is-C
@example
rtems_status_code rtems_partition_ident(
  rtems_name        name,
  rtems_unsigned32  node,
  rtems_id         *id
);
@end example
@end ifset

@ifset is-Ada
@example
procedure Partition_Ident (
   Name   : in     RTEMS.Name;
   Node   : in     RTEMS.Unsigned32;
   ID     :    out RTEMS.ID;
   Result :    out RTEMS.Status_Codes
);
@end example
@end ifset

@subheading DIRECTIVE STATUS CODES:
@code{SUCCESSFUL} - partition identified successfully@*
@code{INVALID_NAME} - partition name not found@*
@code{INVALID_NODE} - invalid node id

@subheading DESCRIPTION:

This directive obtains the partition id associated
with the partition name.  If the partition name is not unique,
then the partition id will match one of the partitions with that
name.  However, this partition id is not guaranteed to
correspond to the desired partition.  The partition id is used
with other partition related directives to access the partition.

@subheading NOTES:

This directive will not cause the running task to be
preempted.

If node is SEARCH_ALL_NODES, all nodes are searched
with the local node being searched first.  All other nodes are
searched with the lowest numbered node searched first.

If node is a valid node number which does not
represent the local node, then only the partitions exported by
the designated node are searched.

This directive does not generate activity on remote
nodes.  It accesses only the local copy of the global object
table.

@page
@ifinfo
@node PARTITION_DELETE - Delete a partition, PARTITION_GET_BUFFER - Get buffer from a partition, PARTITION_IDENT - Get ID of a partition, Partition Manager Directives
@end ifinfo
@subsection PARTITION_DELETE - Delete a partition

@subheading CALLING SEQUENCE:

@ifset is-C
@example
rtems_status_code rtems_partition_delete(
  rtems_id id
);
@end example
@end ifset

@ifset is-Ada
@example
procedure Partition_Delete (
   ID     : in     RTEMS.ID;
   Result :    out RTEMS.Status_Codes
);
@end example
@end ifset

@subheading DIRECTIVE STATUS CODES:
@code{SUCCESSFUL} - partition deleted successfully@*
@code{INVALID_ID} - invalid partition id@*
@code{RESOURCE_IN_USE} - buffers still in use@*
@code{ILLEGAL_ON_REMOTE_OBJECT} - cannot delete remote partition

@subheading DESCRIPTION:

This directive deletes the partition specified by id.
The partition cannot be deleted if any of its buffers are still
allocated.  The PTCB for the deleted partition is reclaimed by
RTEMS.

@subheading NOTES:

This directive will not cause the calling task to be
preempted.

The calling task does not have to be the task that
created the partition.  Any local task that knows the partition
id can delete the partition.

When a global partition is deleted, the partition id
must be transmitted to every node in the system for deletion
from the local copy of the global object table.

The partition must reside on the local node, even if
the partition was created with the GLOBAL option.

@page
@ifinfo
@node PARTITION_GET_BUFFER - Get buffer from a partition, PARTITION_RETURN_BUFFER - Return buffer to a partition, PARTITION_DELETE - Delete a partition, Partition Manager Directives
@end ifinfo
@subsection PARTITION_GET_BUFFER - Get buffer from a partition

@subheading CALLING SEQUENCE:

@ifset is-C
@example
rtems_status_code rtems_partition_get_buffer(
  rtems_id   id,
  void     **buffer
);
@end example
@end ifset

@ifset is-Ada
@example
procedure Partition_Get_Buffer (
   ID     : in     RTEMS.ID;
   Buffer :    out RTEMS.Address;
   Result :    out RTEMS.Status_Codes
);
@end example
@end ifset

@subheading DIRECTIVE STATUS CODES:
@code{SUCCESSFUL} - buffer obtained successfully@*
@code{INVALID_ID} - invalid partition id@*
@code{UNSATISFIED} - all buffers are allocated

@subheading DESCRIPTION:

This directive allows a buffer to be obtained from
the partition specified in id.  The address of the allocated
buffer is returned in buffer.

@subheading NOTES:

This directive will not cause the running task to be
preempted.

All buffers begin on a four byte boundary.

A task cannot wait on a buffer to become available.

Getting a buffer from a global partition which does
not reside on the local node will generate a request telling the
remote node to allocate a buffer from the specified partition.

@page
@ifinfo
@node PARTITION_RETURN_BUFFER - Return buffer to a partition, Region Manager, PARTITION_GET_BUFFER - Get buffer from a partition, Partition Manager Directives
@end ifinfo
@subsection PARTITION_RETURN_BUFFER - Return buffer to a partition

@subheading CALLING SEQUENCE:

@ifset is-C
@example
rtems_status_code rtems_partition_return_buffer(
  rtems_id  id,
  void     *buffer
);
@end example
@end ifset

@ifset is-Ada
@example
procedure Partition_Return_Buffer (
   ID     : in     RTEMS.ID;
   Buffer : in     RTEMS.Address;
   Result :    out RTEMS.Status_Codes
);
@end example
@end ifset

@subheading DIRECTIVE STATUS CODES:
@code{SUCCESSFUL} - buffer returned successfully@*
@code{INVALID_ID} - invalid partition id@*
@code{INVALID_ADDRESS} - buffer address not in partition

@subheading DESCRIPTION:

This directive returns the buffer specified by buffer
to the partition specified by id.

@subheading NOTES:

This directive will not cause the running task to be
preempted.

Returning a buffer to a global partition which does
not reside on the local node will generate a request telling the
remote node to return the buffer to the specified partition.

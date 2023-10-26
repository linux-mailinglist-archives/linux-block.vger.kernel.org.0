Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF1E7D8A9D
	for <lists+linux-block@lfdr.de>; Thu, 26 Oct 2023 23:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjJZVmg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 26 Oct 2023 17:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbjJZVmf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Oct 2023 17:42:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88978129
        for <linux-block@vger.kernel.org>; Thu, 26 Oct 2023 14:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698356500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5FoAt5WC69ut0nWBiRX4I6jKsaxPYFVy5vdHxgEvRuc=;
        b=Nk9vsTTzP4zC5A2rtV1vUixSOH66dm7EVqOz8p0EKb2bLiRzYx29ICe1bmkrCu0kfq1Yux
        ZbSJyVyd5xpS/YvwM/C0hO0EsXS41aN1DVPwT+cC+YPJbHdZpE5glk4luxowAQOYSPP+UC
        nzvP/2V3fkhgMv98qKgMrmen8HQ5+lw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-bMQo0mHPPD-r2akAn_IVjw-1; Thu,
 26 Oct 2023 17:41:37 -0400
X-MC-Unique: bMQo0mHPPD-r2akAn_IVjw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F3FDD29ABA38;
        Thu, 26 Oct 2023 21:41:36 +0000 (UTC)
Received: from pbitcolo-build-10.permabit.com (pbitcolo-build-10.permabit.lab.eng.bos.redhat.com [10.19.117.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DEF4B1121320;
        Thu, 26 Oct 2023 21:41:36 +0000 (UTC)
Received: by pbitcolo-build-10.permabit.com (Postfix, from userid 1138)
        id 951213003C; Thu, 26 Oct 2023 17:41:36 -0400 (EDT)
From:   Matthew Sakai <msakai@redhat.com>
To:     dm-devel@lists.linux.dev, linux-block@vger.kernel.org
Cc:     Matthew Sakai <msakai@redhat.com>
Subject: [PATCH v4 00/39] dm vdo: add the dm-vdo deduplication and compression DM target
Date:   Thu, 26 Oct 2023 17:40:57 -0400
Message-Id: <20231026214136.1067410-1-msakai@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The dm-vdo target provides inline deduplication, compression, zero-block
elimination, and thin provisioning. A dm-vdo target can be backed by up to
256TB of storage, and can present a logical size of up to 4PB. This target
was originally developed at Permabit Technology Corp. starting in 2009. It
was first released in 2013 and has been used in production environments
ever since. It was made open-source in 2017 after Permabit was acquired by
Red Hat.

Because deduplication rates fall drastically as the block size increases, a
vdo target has a maximum block size of 4KB. However, it can achieve
deduplication rates of 254:1, i.e. up to 254 copies of a given 4KB block
can reference a single 4KB of actual storage. It can achieve compression
rates of 14:1. All zero blocks consume no storage at all.

https://github.com/dm-vdo/dm-linux contains the most recent dm-vdo updates.

Design Summary
--------------

This is a high-level summary of the ideas behind dm-vdo. For details about
the implementation and various design choices, refer to vdo-design.rst
included in this patch set.

Deduplication is a two-part problem. The first part is recognizing
duplicate data; the second part is avoiding multiple copies of the
duplicated data. Therefore, vdo has two main sections: a deduplication
index that is used to discover potential duplicate data, and a data store
with a reference counted block map that maps from logical block addresses
to the actual storage location of the data.

Hashing:

In order to identify blocks, vdo hashes each 4KB block to produce a 128-bit
block name. Since vdo only requires these names to be evenly distributed,
it uses MurmurHash3, a non-cryptographic hash algorithm which is faster
than cryptographic hashes.

The Deduplication Index:

The index is a set of mappings between a block name (the hash of its
contents) and a hint indicating where the block might be stored. These
mappings are stored in temporal order because groups of blocks that are
written together (such as a large file) tend to be rewritten together as
well. The index uses a least-recently-used (LRU) scheme to keep frequently
used names in the index while older names are discarded.

The index uses a structure called a delta-index to store its mappings,
which is more space-efficient than using a hashtable. It uses a variable
length encoding with the property that the average size of an entry
decreases as the number of entries increases, resulting in a roughly
constant size as the index fills.

Because storing hashes along with the data, or rehashing blocks on
overwrite is expensive, entries are never explicitly deleted from the
index. Instead, the vdo must always check the data at the physical location
provided by the index to ensure that the hint is still valid.

The Data Store:

The data store is implemented by three main data structures: the block map,
the slab depot, and the recovery journal. These structures work in concert
to amortize metadata updates across as many data writes as possible.

The block map contains the mapping from logical addresses to physical
locations. For each logical address it indicates whether that address is
unused, all zeros, or which physical block holds its contents and whether
or not it is compressed. The array of mappings is represented as a tree,
with nodes that are allocated as needed from the available physical space.

The slab depot tracks the physical space available for storing user data.
The depot also maintains a reference count for each physical block. Each
block can have up to 254 logical references.

The recovery journal is a transaction log of the logical-to-physical
mappings made by data writes. Committing this journal regularly allows a
vdo to reduce the frequency of other metadata writes and allows it to
reconstruct its metadata in the event of a crash.

Zones and Threading:

Due to the complexity of deduplication, the number of metadata structures
involved in a single write operation to a vdo target is larger than most
other targets. Furthermore, because vdo operates on small block sizes in
order to achieve good deduplication rates, parallelism is key to good
performance. The deduplication index, the block map, and the slab depot are
all designed to be easily divided into disjoint zones such that any piece
of metadata is handled by a single zone. Each zone is then assigned to a
single thread so that all metadata operations in that zone can proceed
without locking. Each bio is associated with a request object which can be
enqueued on each zone thread it needs to access. The zone divisions are not
reflected in the on-disk representation of the data structures, so the
number of zones, and hence the number of threads, can be configured each
time a vdo target is started.

Existing facilities
-------------------

In a few cases, we found that existing kernel facilities did not meet vdo's
needs, either because of performance or due to a mismatch of semantics.
These are detailed here:

Work Queues:

Handling a single bio requires a number of small operations across a number
of zones. The per-zone worker threads can be very busy, often using upwards
of 30% CPU time. Kernel work queues seem targeted for lighter work loads.
They do not let us easily prioritize individual tasks within a zone, and
make CPU affinity control at a per-thread level more difficult.

The threads scanning and updating the in-memory portion of the
deduplication index process a large number of queries through a single
function. It uses its own "request queue" mechanism to process these
efficiently in dedicated threads. In experiments using kernel work queues
for the index lookups, we observed an overall throughput drop of up to
almost 10%. In the following table, randwrite% and write% represent the
change in throughput when switching to kernel work queues for random and
sequential write workloads, respectively.

| compression% | deduplication% | randwrite% | write% |
|--------------+----------------+------------+--------|
|            0 |              0 |       -8.3 |   -6.4 |
|           55 |              0 |       -7.9 |   -8.5 |
|           90 |              0 |       -9.3 |   -8.9 |
|            0 |             50 |       -4.9 |   -4.5 |
|           55 |             50 |       -4.4 |   -4.4 |
|           90 |             50 |       -4.2 |   -4.7 |
|            0 |             90 |       -1.0 |    0.7 |
|           55 |             90 |        0.2 |   -0.4 |
|           90 |             90 |       -0.5 |    0.2 |

Mempools:

There are two types of object pools in the vdo implementation for which the
existing mempool structure was not appropriate. The first of these are
pools of structures wrapping the bios used for vdo's metadata I/O. Since
each of these pools is only accessed from a single thread, the locking done
by mempool is a needless cost. The second of these, the single pool of the
wrappers for incoming bios, has more complicated locking semantics than
mempool provides. When a thread attempts to submit a bio to vdo, but the
pool is exhausted, the thread is put to sleep. The pool is designed to only
wake that thread once, when it is certain that the bio submitted by that
thread will be processed. It is not desirable to merely allocate more
wrappers as a number of other vdo structures are designed to handle only a
fixed number of concurrent requests. This limit is also necessary to bound
the amount of work needed when recovering after a crash.

MurmurHash:

MurmurHash3 was selected for its hash quality, performance on 4KB blocks,
and its 128-bit output size (vdo needs significantly more than 64 uniformly
distributed bits for its in-memory and on-disk indexing). For
cross-platform compatibility, vdo uses a modified version which always
produces the same output as the original x64 variant, rather than being
optimized per platform.

For newly created devices, vdo could potentially use another hash algorithm
with similar qualities such as xxhash. For existing devices, however,
changing the hash algorithm means losing all previous deduplication
information. So for existing installations it is highly desirable to retain
support for MurmurHash3.

Matthew Sakai (39):
  dm: add documentation for dm-vdo target
  dm vdo: add the MurmurHash3 fast hashing algorithm
  dm vdo: add memory allocation utilities
  dm vdo: add basic logging and support utilities
  dm vdo: add vdo type declarations, constants, and simple data
    structures
  dm vdo: add thread and synchronization utilities
  dm vdo: add specialized request queueing functionality
  dm vdo: add basic hash map data structures
  dm vdo: add deduplication configuration structures
  dm vdo: add deduplication index storage interface
  dm vdo: implement the delta index
  dm vdo: implement the volume index
  dm vdo: implement the open chapter and chapter indexes
  dm vdo: implement the chapter volume store
  dm vdo: implement top-level deduplication index
  dm vdo: implement external deduplication index interface
  dm vdo: add administrative state and action manager
  dm vdo: add vio, the request object for vdo metadata
  dm vdo: add data_vio, the request object which services incoming bios
  dm vdo: add flush support
  dm vdo: add the vdo io_submitter
  dm vdo: add hash locks and hash zones
  dm vdo: add use of deduplication index in hash zones
  dm vdo: add the compressed block bin packer
  dm vdo: add slab structure, slab journal and reference counters
  dm vdo: add the slab summary
  dm vdo: add the block allocators and physical zones
  dm vdo: add the slab depot
  dm vdo: add the block map
  dm vdo: implement the block map page cache
  dm vdo: add the recovery journal
  dm vdo: add repair of damaged vdo volumes
  dm vdo: add the primary vdo structure
  dm vdo: add the on-disk formats and marshalling of vdo structures
  dm vdo: add statistics reporting
  dm vdo: add sysfs support for setting parameters and fetching stats
  dm vdo: add debugging support
  dm vdo: add the top-level DM target
  dm vdo: enable configuration and building of dm-vdo

 .../admin-guide/device-mapper/vdo-design.rst  |  415 ++
 .../admin-guide/device-mapper/vdo.rst         |  388 ++
 drivers/md/Kconfig                            |   16 +
 drivers/md/Makefile                           |    2 +
 drivers/md/dm-vdo-target.c                    | 2982 ++++++++++
 drivers/md/dm-vdo/action-manager.c            |  410 ++
 drivers/md/dm-vdo/action-manager.h            |  117 +
 drivers/md/dm-vdo/admin-state.c               |  512 ++
 drivers/md/dm-vdo/admin-state.h               |  180 +
 drivers/md/dm-vdo/block-map.c                 | 3376 +++++++++++
 drivers/md/dm-vdo/block-map.h                 |  397 ++
 drivers/md/dm-vdo/chapter-index.c             |  304 +
 drivers/md/dm-vdo/chapter-index.h             |   66 +
 drivers/md/dm-vdo/completion.c                |  141 +
 drivers/md/dm-vdo/completion.h                |  155 +
 drivers/md/dm-vdo/config.c                    |  389 ++
 drivers/md/dm-vdo/config.h                    |  125 +
 drivers/md/dm-vdo/constants.c                 |   15 +
 drivers/md/dm-vdo/constants.h                 |  102 +
 drivers/md/dm-vdo/cpu.h                       |   58 +
 drivers/md/dm-vdo/data-vio.c                  | 2076 +++++++
 drivers/md/dm-vdo/data-vio.h                  |  683 +++
 drivers/md/dm-vdo/dedupe.c                    | 3073 ++++++++++
 drivers/md/dm-vdo/dedupe.h                    |  119 +
 drivers/md/dm-vdo/delta-index.c               | 2018 +++++++
 drivers/md/dm-vdo/delta-index.h               |  292 +
 drivers/md/dm-vdo/dump.c                      |  288 +
 drivers/md/dm-vdo/dump.h                      |   17 +
 drivers/md/dm-vdo/encodings.c                 | 1488 +++++
 drivers/md/dm-vdo/encodings.h                 | 1307 +++++
 drivers/md/dm-vdo/errors.c                    |  316 +
 drivers/md/dm-vdo/errors.h                    |   83 +
 drivers/md/dm-vdo/flush.c                     |  563 ++
 drivers/md/dm-vdo/flush.h                     |   44 +
 drivers/md/dm-vdo/funnel-queue.c              |  169 +
 drivers/md/dm-vdo/funnel-queue.h              |  110 +
 drivers/md/dm-vdo/geometry.c                  |  205 +
 drivers/md/dm-vdo/geometry.h                  |  137 +
 drivers/md/dm-vdo/hash-utils.h                |   66 +
 drivers/md/dm-vdo/index-layout.c              | 1775 ++++++
 drivers/md/dm-vdo/index-layout.h              |   43 +
 drivers/md/dm-vdo/index-page-map.c            |  181 +
 drivers/md/dm-vdo/index-page-map.h            |   54 +
 drivers/md/dm-vdo/index-session.c             |  746 +++
 drivers/md/dm-vdo/index-session.h             |   84 +
 drivers/md/dm-vdo/index.c                     | 1403 +++++
 drivers/md/dm-vdo/index.h                     |   84 +
 drivers/md/dm-vdo/int-map.c                   |  710 +++
 drivers/md/dm-vdo/int-map.h                   |   40 +
 drivers/md/dm-vdo/io-factory.c                |  423 ++
 drivers/md/dm-vdo/io-factory.h                |   66 +
 drivers/md/dm-vdo/io-submitter.c              |  483 ++
 drivers/md/dm-vdo/io-submitter.h              |   52 +
 drivers/md/dm-vdo/logger.c                    |  304 +
 drivers/md/dm-vdo/logger.h                    |  112 +
 drivers/md/dm-vdo/logical-zone.c              |  378 ++
 drivers/md/dm-vdo/logical-zone.h              |   87 +
 drivers/md/dm-vdo/memory-alloc.c              |  447 ++
 drivers/md/dm-vdo/memory-alloc.h              |  171 +
 drivers/md/dm-vdo/message-stats.c             | 1215 ++++
 drivers/md/dm-vdo/message-stats.h             |   13 +
 drivers/md/dm-vdo/murmurhash3.c               |  175 +
 drivers/md/dm-vdo/murmurhash3.h               |   15 +
 drivers/md/dm-vdo/numeric.h                   |   78 +
 drivers/md/dm-vdo/open-chapter.c              |  433 ++
 drivers/md/dm-vdo/open-chapter.h              |   79 +
 drivers/md/dm-vdo/packer.c                    |  794 +++
 drivers/md/dm-vdo/packer.h                    |  123 +
 drivers/md/dm-vdo/permassert.c                |   35 +
 drivers/md/dm-vdo/permassert.h                |   65 +
 drivers/md/dm-vdo/physical-zone.c             |  650 ++
 drivers/md/dm-vdo/physical-zone.h             |  115 +
 drivers/md/dm-vdo/pointer-map.c               |  691 +++
 drivers/md/dm-vdo/pointer-map.h               |   81 +
 drivers/md/dm-vdo/pool-sysfs-stats.c          | 2063 +++++++
 drivers/md/dm-vdo/pool-sysfs.c                |  193 +
 drivers/md/dm-vdo/pool-sysfs.h                |   19 +
 drivers/md/dm-vdo/priority-table.c            |  226 +
 drivers/md/dm-vdo/priority-table.h            |   48 +
 drivers/md/dm-vdo/radix-sort.c                |  349 ++
 drivers/md/dm-vdo/radix-sort.h                |   28 +
 drivers/md/dm-vdo/recovery-journal.c          | 1772 ++++++
 drivers/md/dm-vdo/recovery-journal.h          |  313 +
 drivers/md/dm-vdo/repair.c                    | 1775 ++++++
 drivers/md/dm-vdo/repair.h                    |   14 +
 drivers/md/dm-vdo/request-queue.c             |  284 +
 drivers/md/dm-vdo/request-queue.h             |   30 +
 drivers/md/dm-vdo/slab-depot.c                | 5213 +++++++++++++++++
 drivers/md/dm-vdo/slab-depot.h                |  594 ++
 drivers/md/dm-vdo/sparse-cache.c              |  595 ++
 drivers/md/dm-vdo/sparse-cache.h              |   49 +
 drivers/md/dm-vdo/statistics.h                |  278 +
 drivers/md/dm-vdo/status-codes.c              |  126 +
 drivers/md/dm-vdo/status-codes.h              |  112 +
 drivers/md/dm-vdo/string-utils.c              |   28 +
 drivers/md/dm-vdo/string-utils.h              |   23 +
 drivers/md/dm-vdo/sysfs.c                     |   84 +
 drivers/md/dm-vdo/thread-cond-var.c           |   46 +
 drivers/md/dm-vdo/thread-device.c             |   35 +
 drivers/md/dm-vdo/thread-device.h             |   19 +
 drivers/md/dm-vdo/thread-registry.c           |   93 +
 drivers/md/dm-vdo/thread-registry.h           |   33 +
 drivers/md/dm-vdo/time-utils.h                |   28 +
 drivers/md/dm-vdo/types.h                     |  393 ++
 drivers/md/dm-vdo/uds-sysfs.c                 |  185 +
 drivers/md/dm-vdo/uds-sysfs.h                 |   12 +
 drivers/md/dm-vdo/uds-threads.c               |  186 +
 drivers/md/dm-vdo/uds-threads.h               |  115 +
 drivers/md/dm-vdo/uds.h                       |  328 ++
 drivers/md/dm-vdo/vdo.c                       | 1845 ++++++
 drivers/md/dm-vdo/vdo.h                       |  381 ++
 drivers/md/dm-vdo/vio.c                       |  525 ++
 drivers/md/dm-vdo/vio.h                       |  221 +
 drivers/md/dm-vdo/volume-index.c              | 1277 ++++
 drivers/md/dm-vdo/volume-index.h              |  192 +
 drivers/md/dm-vdo/volume.c                    | 1793 ++++++
 drivers/md/dm-vdo/volume.h                    |  175 +
 drivers/md/dm-vdo/wait-queue.c                |  223 +
 drivers/md/dm-vdo/wait-queue.h                |  129 +
 drivers/md/dm-vdo/work-queue.c                |  659 +++
 drivers/md/dm-vdo/work-queue.h                |   53 +
 121 files changed, 58571 insertions(+)
 create mode 100644 Documentation/admin-guide/device-mapper/vdo-design.rst
 create mode 100644 Documentation/admin-guide/device-mapper/vdo.rst
 create mode 100644 drivers/md/dm-vdo-target.c
 create mode 100644 drivers/md/dm-vdo/action-manager.c
 create mode 100644 drivers/md/dm-vdo/action-manager.h
 create mode 100644 drivers/md/dm-vdo/admin-state.c
 create mode 100644 drivers/md/dm-vdo/admin-state.h
 create mode 100644 drivers/md/dm-vdo/block-map.c
 create mode 100644 drivers/md/dm-vdo/block-map.h
 create mode 100644 drivers/md/dm-vdo/chapter-index.c
 create mode 100644 drivers/md/dm-vdo/chapter-index.h
 create mode 100644 drivers/md/dm-vdo/completion.c
 create mode 100644 drivers/md/dm-vdo/completion.h
 create mode 100644 drivers/md/dm-vdo/config.c
 create mode 100644 drivers/md/dm-vdo/config.h
 create mode 100644 drivers/md/dm-vdo/constants.c
 create mode 100644 drivers/md/dm-vdo/constants.h
 create mode 100644 drivers/md/dm-vdo/cpu.h
 create mode 100644 drivers/md/dm-vdo/data-vio.c
 create mode 100644 drivers/md/dm-vdo/data-vio.h
 create mode 100644 drivers/md/dm-vdo/dedupe.c
 create mode 100644 drivers/md/dm-vdo/dedupe.h
 create mode 100644 drivers/md/dm-vdo/delta-index.c
 create mode 100644 drivers/md/dm-vdo/delta-index.h
 create mode 100644 drivers/md/dm-vdo/dump.c
 create mode 100644 drivers/md/dm-vdo/dump.h
 create mode 100644 drivers/md/dm-vdo/encodings.c
 create mode 100644 drivers/md/dm-vdo/encodings.h
 create mode 100644 drivers/md/dm-vdo/errors.c
 create mode 100644 drivers/md/dm-vdo/errors.h
 create mode 100644 drivers/md/dm-vdo/flush.c
 create mode 100644 drivers/md/dm-vdo/flush.h
 create mode 100644 drivers/md/dm-vdo/funnel-queue.c
 create mode 100644 drivers/md/dm-vdo/funnel-queue.h
 create mode 100644 drivers/md/dm-vdo/geometry.c
 create mode 100644 drivers/md/dm-vdo/geometry.h
 create mode 100644 drivers/md/dm-vdo/hash-utils.h
 create mode 100644 drivers/md/dm-vdo/index-layout.c
 create mode 100644 drivers/md/dm-vdo/index-layout.h
 create mode 100644 drivers/md/dm-vdo/index-page-map.c
 create mode 100644 drivers/md/dm-vdo/index-page-map.h
 create mode 100644 drivers/md/dm-vdo/index-session.c
 create mode 100644 drivers/md/dm-vdo/index-session.h
 create mode 100644 drivers/md/dm-vdo/index.c
 create mode 100644 drivers/md/dm-vdo/index.h
 create mode 100644 drivers/md/dm-vdo/int-map.c
 create mode 100644 drivers/md/dm-vdo/int-map.h
 create mode 100644 drivers/md/dm-vdo/io-factory.c
 create mode 100644 drivers/md/dm-vdo/io-factory.h
 create mode 100644 drivers/md/dm-vdo/io-submitter.c
 create mode 100644 drivers/md/dm-vdo/io-submitter.h
 create mode 100644 drivers/md/dm-vdo/logger.c
 create mode 100644 drivers/md/dm-vdo/logger.h
 create mode 100644 drivers/md/dm-vdo/logical-zone.c
 create mode 100644 drivers/md/dm-vdo/logical-zone.h
 create mode 100644 drivers/md/dm-vdo/memory-alloc.c
 create mode 100644 drivers/md/dm-vdo/memory-alloc.h
 create mode 100644 drivers/md/dm-vdo/message-stats.c
 create mode 100644 drivers/md/dm-vdo/message-stats.h
 create mode 100644 drivers/md/dm-vdo/murmurhash3.c
 create mode 100644 drivers/md/dm-vdo/murmurhash3.h
 create mode 100644 drivers/md/dm-vdo/numeric.h
 create mode 100644 drivers/md/dm-vdo/open-chapter.c
 create mode 100644 drivers/md/dm-vdo/open-chapter.h
 create mode 100644 drivers/md/dm-vdo/packer.c
 create mode 100644 drivers/md/dm-vdo/packer.h
 create mode 100644 drivers/md/dm-vdo/permassert.c
 create mode 100644 drivers/md/dm-vdo/permassert.h
 create mode 100644 drivers/md/dm-vdo/physical-zone.c
 create mode 100644 drivers/md/dm-vdo/physical-zone.h
 create mode 100644 drivers/md/dm-vdo/pointer-map.c
 create mode 100644 drivers/md/dm-vdo/pointer-map.h
 create mode 100644 drivers/md/dm-vdo/pool-sysfs-stats.c
 create mode 100644 drivers/md/dm-vdo/pool-sysfs.c
 create mode 100644 drivers/md/dm-vdo/pool-sysfs.h
 create mode 100644 drivers/md/dm-vdo/priority-table.c
 create mode 100644 drivers/md/dm-vdo/priority-table.h
 create mode 100644 drivers/md/dm-vdo/radix-sort.c
 create mode 100644 drivers/md/dm-vdo/radix-sort.h
 create mode 100644 drivers/md/dm-vdo/recovery-journal.c
 create mode 100644 drivers/md/dm-vdo/recovery-journal.h
 create mode 100644 drivers/md/dm-vdo/repair.c
 create mode 100644 drivers/md/dm-vdo/repair.h
 create mode 100644 drivers/md/dm-vdo/request-queue.c
 create mode 100644 drivers/md/dm-vdo/request-queue.h
 create mode 100644 drivers/md/dm-vdo/slab-depot.c
 create mode 100644 drivers/md/dm-vdo/slab-depot.h
 create mode 100644 drivers/md/dm-vdo/sparse-cache.c
 create mode 100644 drivers/md/dm-vdo/sparse-cache.h
 create mode 100644 drivers/md/dm-vdo/statistics.h
 create mode 100644 drivers/md/dm-vdo/status-codes.c
 create mode 100644 drivers/md/dm-vdo/status-codes.h
 create mode 100644 drivers/md/dm-vdo/string-utils.c
 create mode 100644 drivers/md/dm-vdo/string-utils.h
 create mode 100644 drivers/md/dm-vdo/sysfs.c
 create mode 100644 drivers/md/dm-vdo/thread-cond-var.c
 create mode 100644 drivers/md/dm-vdo/thread-device.c
 create mode 100644 drivers/md/dm-vdo/thread-device.h
 create mode 100644 drivers/md/dm-vdo/thread-registry.c
 create mode 100644 drivers/md/dm-vdo/thread-registry.h
 create mode 100644 drivers/md/dm-vdo/time-utils.h
 create mode 100644 drivers/md/dm-vdo/types.h
 create mode 100644 drivers/md/dm-vdo/uds-sysfs.c
 create mode 100644 drivers/md/dm-vdo/uds-sysfs.h
 create mode 100644 drivers/md/dm-vdo/uds-threads.c
 create mode 100644 drivers/md/dm-vdo/uds-threads.h
 create mode 100644 drivers/md/dm-vdo/uds.h
 create mode 100644 drivers/md/dm-vdo/vdo.c
 create mode 100644 drivers/md/dm-vdo/vdo.h
 create mode 100644 drivers/md/dm-vdo/vio.c
 create mode 100644 drivers/md/dm-vdo/vio.h
 create mode 100644 drivers/md/dm-vdo/volume-index.c
 create mode 100644 drivers/md/dm-vdo/volume-index.h
 create mode 100644 drivers/md/dm-vdo/volume.c
 create mode 100644 drivers/md/dm-vdo/volume.h
 create mode 100644 drivers/md/dm-vdo/wait-queue.c
 create mode 100644 drivers/md/dm-vdo/wait-queue.h
 create mode 100644 drivers/md/dm-vdo/work-queue.c
 create mode 100644 drivers/md/dm-vdo/work-queue.h


base-commit: 1e4ab7b4c881cf26c1c72b3f56519e03475486fb
-- 
2.40.0


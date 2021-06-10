Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197EB3A21DC
	for <lists+linux-block@lfdr.de>; Thu, 10 Jun 2021 03:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhFJBev (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 9 Jun 2021 21:34:51 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:55772 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFJBeu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 21:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623288774; x=1654824774;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8cenp8iylu2gpczlfliCEsbEMihj49bTnoUDr6oWVmc=;
  b=E1XJf3kCl9a9mzo00Ydm6u0wKs1Su5eQqmkKO/cR/KgtxpWaxfTWKwfb
   Yfnsakrg9DmpOBBWybLAlmzaJD9U/Mg3YgHKrqF1hZ+6AMl+l08lWhb+v
   N0ATj7z76Zga9eTncFLGx/h1WT6GMFTD1sCC0Od0HJ2xcWC46nGWojYjj
   ueE1LmrBtJT1bn8b+/zB2h/qgcWJLhLuZk6KAi4m3DKVCLSVyLgPhpj/t
   uszTK2yXUD9UO2ThYDwgf2TuQnHhnsqRkDR91i8rRZRpleySsrLfTpxvj
   koGCb/67yJQMD9qHVLBA07yAlCCFVkgBS4FPHNM88TOnV5DPkCewh/6ra
   A==;
IronPort-SDR: Kw5SeqHJKmJ6MEg2D3roG535riPS+1rmgRQXdUGASN8Ixy8TM/8AiRB0hYrgEqf10Hev+D5MIN
 LEIMeUIun4lVbtYr2Q59C7rn4IaQC13fVoPF21b+rBKUJPJo0uM8bq+jJPnDemy9dXQPJjLQGO
 k85J4u9jW9nBpExR4d6nqyZk3NlP53N5zYGVN2k5S3Deq4j4YDdm8+qwKMiU5P6iKgxRlK3uX5
 jeCS+Xq1iJO96TU/3PBxWC2QHQj5JwI7/EWQe0FmwEALe1hdtBry+bizFes35t0HjvBVIfW08j
 1FU=
X-IronPort-AV: E=Sophos;i="5.83,262,1616428800"; 
   d="scan'208";a="171382248"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2021 09:32:53 +0800
IronPort-SDR: HAacm9gf9HNMkqtxrMS6ZX7mDKntyCHQ0ZkJDiLXOlW1KhxsomLKaVTOXB11t6TQ71T4Mdn3dL
 2ehWjEBp/pipdSv8B19fbyM0Vx8b+lT4ehYXBVD2R9Cece/6sv1wQWkxTmqKd6seAo1t+aoOTk
 lS7j5YZeFaqv7a5RsLny6H+Lk97y90qgV3QHHmdskHs/AcLvy97t994bYPyq7GLObaJNcA7UGw
 oz/11SXp+BhbqKqmfN6IioMpcmTJmbC++TcXNtrfvn4r6dWB8WyKSP7AyK+ZrUq/fPAnSuktYU
 X/Y70XkA9BhsgsgESkuAlgOw
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 18:11:57 -0700
IronPort-SDR: nG6XAJCnMtoDw2d/K8txhMO51LyVuaV45WKbjWGF4O+gbQeoKx4THNRG2YvesYa0lEVanJ1TYX
 1aZXVTErF7nMbyoU26Rz4drhBh7kDTew5unQOQRFfywNvCnvwLEhQDqb6yDqhWuWCbupmtn8eT
 Tm1W/vdN7Fx1LcJbDu3jD3KgUblkZtcIOF89Z6tLWggX6YVGM6lg/fkGOIEcCRdw9wmbFHl0B7
 uW2VuDhT4cufInVTp+oChtOs3VJ4gsCfWcvUiQ5u0KmC1cCTirq+gwNEOPVUuPvchU/yTySwGv
 XFM=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Jun 2021 18:32:54 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     axboe@kernel.dk, sagi@grimberg.me, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V15 0/5] nvmet: add ZBD backened support
Date:   Wed,  9 Jun 2021 18:32:47 -0700
Message-Id: <20210610013252.53874-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

NVMeOF Host is capable of handling the NVMe Protocol based Zoned Block
Devices (ZBD) in the Zoned Namespaces (ZNS) mode with the passthru
backend. There is no support for a generic block device backend to
handle the ZBDs which are not NVMe protocol compliant.

This adds support to export the ZBDs (which are not NVMe drives) to host
from the target via NVMeOF using the host side ZNS interface.

Note: This patch-series is based on nvme-5.14.

-ck

Chaitanya Kulkarni (5):
  block: export blk_next_bio()
  nvmet: add req cns error complete helper
  nvmet: add nvmet_req_bio put helper for backends
  nvmet: add Command Set Identifier support
  nvmet: add ZBD over ZNS backend support

 block/blk-lib.c                   |   1 +
 drivers/nvme/target/Makefile      |   1 +
 drivers/nvme/target/admin-cmd.c   | 121 +++++-
 drivers/nvme/target/core.c        |  43 ++-
 drivers/nvme/target/io-cmd-bdev.c |  29 +-
 drivers/nvme/target/nvmet.h       |  35 ++
 drivers/nvme/target/passthru.c    |   3 +-
 drivers/nvme/target/zns.c         | 622 ++++++++++++++++++++++++++++++
 include/linux/bio.h               |   2 +
 include/linux/nvme.h              |   8 +
 10 files changed, 828 insertions(+), 37 deletions(-)
 create mode 100644 drivers/nvme/target/zns.c

Changes since V14:-

1. Remove the unsingned long cast in the call to set_bit().
2. Update reviewed-by tag.

Changes since V13:-

1. Move the code cleanup patches upfront and export blk_next_bio().
2. Remove NVM in the subject line for the CSS patch.
3. Remove the switch from nvmet_execute_identify_desclist_csi()
   and use ns->csi directly.
4. Add csi switch in the nvmet_parse_io_cmd().
5. Rename nvmet_cc_css_check() -> nvmet_css_supported().
6. Remove switch from nvmet_set_csi_zns_effects().
7. Rename nvmet_set_csi_nvm_effects() ->
   nvmet_get_cmd_effects_nvm().
7. Add separate parse case for the different csi.
8. Remove the bdev_is_zoned().
9. Remove the csi check from the admin cmd handlers and move
   to the caller.
10. Add Zone State change emulation and add state machine check
    to handle zone mgmt send command.
12. Abort the zone append command with error when transfer len = 0.
13. Don't allocate the buffer for zone mgmt recv report zones instead
    use the command data buffer.
14. Overall small cleanups to reflect the new code changes.
15. Offload zone-mgmt commands to workqueue.

Changes since V12:-

1. Remove the comment :-
  /* bdev_is_zoned() is stubbed out of CONFIG_BLK_DEV_ZONED */
2. Update copyright header.
3. Use folliwng expression in nvmet_zasl(). 
   return ilog2(zone_append_sects >> (NVMET_MPSMIN_SHIFT - 9));
4. Add comment in nvmet_bdev_zns_enable().
5. Add zone filtering and partial bit handling.
6. Use if else pattern in nvmet_bdev_execute_zone_mgmt_send().
7. Make zone append async. 
8. Add a comment for nvmet_check_transfer_len().
9. Add a helper nvmet_req_cns_error_compplete() to remove the duplicate
   code.

Changes from V11:-

1. Use bdev_logical_block_size() in nvmet_bdev_zns_enable().
2. Return error if nr_zones calculation ends up having value 0.
4. Drop the comment patch from this series :-
   nvme: add comments to nvme_zns_alloc_report_buffer

Changes from V10:-

1.  Move CONFIG_BLK_DEV_ZONED check into the caller of
    nvmet_set_csi_zns_effects().
2.  Move ZNS related csi code from csi patch to its own ZNS backend
    patch.
3.  For ZNS command effects logs set default command effects with 
    nvmet_set_csi_nvm_effects() along with nvmet_set_csi_zns_effects().
4.  Use goto for failure case in the nvmet_set_csi_zns_effects().
5.  Return directly from swicth in nvmet_execute_identify_desclist_csi().
6.  Merge Patch 2nd/3rd into one patch and move ZNS related code
    into its own :-
     [PATCH V10 2/8] nvmet: add NVM Command Set Identifier support
     [PATCH V10 3/8] nvmet: add command set supported ctrl cap
    Merged into new patch minux ZNS calls :-
     [PATCH V11 1/4] nvmet: add NVM Command Set Identifier support
7.  Move req->cmd->identify.csi == NVME_CSI_ZNS checks in to respective
    caller in nvmet_execute_identify().
8.  Update error log page in nvmet_bdev_zns_checks().
9.  Remove the terney expression nvmet_zns_update_zasl().
10. Drop following patches:-
     [PATCH V10 1/8] nvmet: trim args for nvmet_copy_ns_identifier()
     [PATCH V10 6/8] nvme-core: check ctrl css before setting up zns
     [PATCH V10 7/8] nvme-core: add a helper to print css related error

Changes from V9:-

1.  Use bio_add_zone_append_page() for REQ_OP_ZONE_APPEND.
2.  Add a separate prep patch to reduce the arguments for
    nvmet_copy_ns_identifier().
3.  Add a separate patch for nvmet CSI support.
4.  Add a separate patch for nvmet CSS support.
5.  Move nvmet_cc_css_check() to multi-css supported patch.
6.  Return error in csi cmd effects helper when !CONFIG_BLK_DEV_ZONED.
7.  Return error in id desc list helper when !CONFIG_BLK_DEV_ZONED.
8.  Remove goto and return from nvmet_bdev_zns_checks().
9.  Move nr_zones calculations near call to blkdev_report_zones() in
    nvmet_bdev_execute_zone_mgmt_recv().
10. Split command effects logs into respective CSI helpers.
11. Don't use the local variables to pass NVME_CSI_XXX values, instead
    use req->ns->csi, also move this from ZBD support patch to nvmet
    CSI support.
12. Fix the bug that is chekcing cns value instead of csi in identify.
13. bdev_is_zoned() is stubbed out the CONFIG_BLK_DEV_ZONED, so remove
    the check for CONFIG_BLK_DEV_ZONED before calling bdev_is_zoned().
14  Drop following patches :-
    [PATCH V9 1/9] block: export bio_add_hw_pages().
    [PATCH V9 5/9] nvmet: add bio get helper.
    [PATCH V9 6/9] nvmet: add bio init helper.
    [PATCH V9 8/9] nvmet: add common I/O length check helper.
    [PATCH V9 9/9] nvmet: call nvmet_bio_done() for zone append.
15. Add a patch to check for ctrl bits to make sure ctrl supports the
    multi css on the host side when setting up Zoned Namespace.
17. Add a documentation patch for the host side when calculating the
    buffer size allocation size for the report zones.
16. Rebase and retest 5.12-rc1.

Changes from V8:-

1. Rebase and retest on latest nvme-5.11.
2. Export ctrl->cap csi support only if CONFIG_BLK_DEV_ZONE is set.
3. Add a fix to admin ns-desc list handler for handling default csi.

Changes from V7:-

1. Just like what block layer provides an API for bio_init(), provide
   nvmet_bio_init() such that we move bio initialization code for
   nvme-read-write commands from bdev and zns backend into the centralize
   helper. 
2. With bdev/zns/file now we have three backends that are checking for
   req->sg_cnt and calling nvmet_check_transfer_len() before we process
   nvme-read-write commands. Move this duplicate code from three
   backeneds into the helper.
3. Export and use nvmet_bio_done() callback in
   nvmet_execute_zone_append() instead of the open coding the function.
   This also avoids code duplication for bio & request completion with
   error log page update.
4. Add zonefs tests log for dm linear device created on the top of SMR HDD
   exported with NVMeOF ZNS backend with the help of nvme-loop.

Changes from V6:-

1. Instead of calling report zones to find conventional zones in the 
   loop use the loop inside LLD blkdev_report_zones()->LLD_report_zones,
   that also simplifies the report zone callback.
2. Fix the bug in nvmet_bdev_has_conv_zones().
3. Remove conditional operators in the nvmet_bdev_execute_zone_append().

Changes from V5:-

1.  Use bio->bi_iter.bi_sector for result of the REQ_OP_ZONE_APPEND
    command.
2.  Add endianness to the helper nvmet_sect_to_lba().
3.  Make bufsize u32 in zone mgmt recv command handler.
4.  Add __GFP_ZERO for report zone data buffer to return clean buffer.

Changes from V4:-

1.  Don't use bio_iov_iter_get_pages() instead add a patch to export
    bio_add_hw_page() and call it directly for zone append.
2.  Add inline vector optimization for append bio.
3.  Update the commit logs for the patches.
4.  Remove ZNS related identify data structures, use individual members.
5.  Add a comment for macro NVMET_MPSMIN_SHIFT.
6.  Remove nvmet_bdev() helper.
7.  Move the command set identifier code into common code.
8.  Use IS_ENABLED() and move helpers fomr zns.c into common code.
9.  Add a patch to support Command Set identifiers.
10. Open code nvmet_bdev_validate_zns_zones().
11. Remove the per namespace min zasl calculation and don't allow
    namespaces with zasl value > the first ns zasl value.
12. Move the stubs into the header file.
13. Add lba to/from sector conversion helpers and update the
    io-cmd-bdev.c to avoid the code duplication.
14. Add everything into one patch for zns command handlers and 
    respective calls from the target code.
15. Remove the trim ns-desclist admin callback patch from this series.
16. Add bio get and put helpers patches to reduce the duplicate code in
    generic bdev, passthru, and generic zns backend.

Changes from V3:-

1.  Get rid of the bio_max_zasl check.
2.  Remove extra lines.
3.  Remove the block layer api export patch.
4.  Remove the bvec check in the bio_iov_iter_get_pages() for
    REQ_OP_ZONE_APPEND so that we can reuse the code.

Changes from V2:-

1.  Move conventional zone bitmap check into 
    nvmet_bdev_validate_zns_zones(). 
2.  Don't use report zones call to check the runt zone.
3.  Trim nvmet_zasl() helper.
4.  Fix typo in the nvmet_zns_update_zasl().
5.  Remove the comment and fix the mdts calculation in
    nvmet_execute_identify_cns_cs_ctrl().
6.  Use u64 for bufsize in nvmet_bdev_execute_zone_mgmt_recv().
7.  Remove nvmet_zones_to_desc_size() and fix the nr_zones
    calculation.
8.  Remove the op variable in nvmet_bdev_execute_zone_append().
9.  Fix the nr_zones calculation nvmet_bdev_execute_zone_mgmt_recv().
10. Update cover letter subject.

Changes from V1:-

1.  Remove the nvmet-$(CONFIG_BLK_DEV_ZONED) += zns.o.
2.  Mark helpers inline.
3.  Fix typos in the comments and update the comments.
4.  Get rid of the curly brackets.
5.  Don't allow drives with last smaller zones.
6.  Calculate the zasl as a function of ax_zone_append_sectors,
    bio_max_pages so we don't have to split the bio.
7.  Add global subsys->zasl and update the zasl when new namespace
    is enabled.
8.  Rmove the loop in the nvmet_bdev_execute_zone_mgmt_recv() and
    move functionality in to the report zone callback.
9.  Add goto for default case in nvmet_bdev_execute_zone_mgmt_send().
10. Allocate the zones buffer with zones size instead of bdev nr_zones.

-- 
2.22.1


Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FFB7946BC
	for <lists+linux-block@lfdr.de>; Thu,  7 Sep 2023 00:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242842AbjIFW7T (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 6 Sep 2023 18:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjIFW7T (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Sep 2023 18:59:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA7819A9;
        Wed,  6 Sep 2023 15:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694041155; x=1725577155;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iZpacsJmtPibvRYCVTNE2cwagSSO7Bbbq8tQpQEh6CI=;
  b=jMdG8uWYkmbLcw8PDu2Me4eS7cVHoJLWNjsYqHwXA1IXNl7PgKyjz3tc
   TB1KLGAHGxVMmTn8bjjxv1qJ8AQUvhWJwTWaQGYuWVSdxMuQb1nhjIzKU
   a9gW1vN907KAfwbwyt5780n7yXS7VamyunJNlE7p4EB09yvITSXmHItFs
   4SAtdQacKqxWj5sh1k1xsdAiW/2mfCjRKyS2v39G50tHgokShFkLiREBL
   x3dce893sHuBfTNd1ZlPGU5m1uwo3ZemhEkZ/GAx45q2P7QK3EAYvaFwC
   1PtcTJFy4WgTQJ2NWuSsKuHAEqBkuxahJtMLLaIHhzo+iAwUBvf6p89sT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="463582382"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="463582382"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 15:59:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="691498791"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="691498791"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 06 Sep 2023 15:59:08 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qe1UI-0000ff-0E;
        Wed, 06 Sep 2023 22:59:06 +0000
Date:   Thu, 7 Sep 2023 06:58:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nitesh Shetty <nj.shetty@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, martin.petersen@oracle.com,
        mcgrof@kernel.org, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Anuj Gupta <anuj20.g@samsung.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v15 12/12] null_blk: add support for copy offload
Message-ID: <202309070607.akFEF327-lkp@intel.com>
References: <20230906163844.18754-13-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906163844.18754-13-nj.shetty@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Nitesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on c50216cfa084d5eb67dc10e646a3283da1595bb6]

url:    https://github.com/intel-lab-lkp/linux/commits/Nitesh-Shetty/block-Introduce-queue-limits-and-sysfs-for-copy-offload-support/20230907-015817
base:   c50216cfa084d5eb67dc10e646a3283da1595bb6
patch link:    https://lore.kernel.org/r/20230906163844.18754-13-nj.shetty%40samsung.com
patch subject: [PATCH v15 12/12] null_blk: add support for copy offload
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20230907/202309070607.akFEF327-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230907/202309070607.akFEF327-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309070607.akFEF327-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/trace/define_trace.h:102,
                    from drivers/block/null_blk/trace.h:104,
                    from drivers/block/null_blk/main.c:15:
   drivers/block/null_blk/./trace.h: In function 'trace_raw_output_nullb_copy_op':
>> drivers/block/null_blk/./trace.h:91:27: warning: format '%lu' expects argument of type 'long unsigned int', but argument 7 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
      91 |                 TP_printk("%s req=%-15s: dst=%llu, src=%llu, len=%lu",
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:203:34: note: in definition of macro 'DECLARE_EVENT_CLASS'
     203 |         trace_event_printf(iter, print);                                \
         |                                  ^~~~~
   include/trace/trace_events.h:45:30: note: in expansion of macro 'PARAMS'
      45 |                              PARAMS(print));                   \
         |                              ^~~~~~
   drivers/block/null_blk/./trace.h:73:1: note: in expansion of macro 'TRACE_EVENT'
      73 | TRACE_EVENT(nullb_copy_op,
         | ^~~~~~~~~~~
   drivers/block/null_blk/./trace.h:91:17: note: in expansion of macro 'TP_printk'
      91 |                 TP_printk("%s req=%-15s: dst=%llu, src=%llu, len=%lu",
         |                 ^~~~~~~~~
   In file included from include/trace/trace_events.h:237:
   drivers/block/null_blk/./trace.h:91:68: note: format string is defined here
      91 |                 TP_printk("%s req=%-15s: dst=%llu, src=%llu, len=%lu",
         |                                                                  ~~^
         |                                                                    |
         |                                                                    long unsigned int
         |                                                                  %u


vim +91 drivers/block/null_blk/./trace.h

    72	
    73	TRACE_EVENT(nullb_copy_op,
    74			TP_PROTO(struct request *req,
    75				 sector_t dst, sector_t src, size_t len),
    76			TP_ARGS(req, dst, src, len),
    77			TP_STRUCT__entry(
    78					 __array(char, disk, DISK_NAME_LEN)
    79					 __field(enum req_op, op)
    80					 __field(sector_t, dst)
    81					 __field(sector_t, src)
    82					 __field(size_t, len)
    83			),
    84			TP_fast_assign(
    85				       __entry->op = req_op(req);
    86				       __assign_disk_name(__entry->disk, req->q->disk);
    87				       __entry->dst = dst;
    88				       __entry->src = src;
    89				       __entry->len = len;
    90			),
  > 91			TP_printk("%s req=%-15s: dst=%llu, src=%llu, len=%lu",
    92				  __print_disk_name(__entry->disk),
    93				  blk_op_str(__entry->op),
    94				  __entry->dst, __entry->src, __entry->len)
    95	);
    96	#endif /* _TRACE_NULLB_H */
    97	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

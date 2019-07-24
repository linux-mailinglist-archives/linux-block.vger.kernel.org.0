Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7EF740DF
	for <lists+linux-block@lfdr.de>; Wed, 24 Jul 2019 23:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfGXVdu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 24 Jul 2019 17:33:50 -0400
Received: from mga09.intel.com ([134.134.136.24]:41434 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbfGXVdu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jul 2019 17:33:50 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2019 14:33:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,304,1559545200"; 
   d="scan'208";a="181251022"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga002.jf.intel.com with ESMTP; 24 Jul 2019 14:33:49 -0700
Date:   Wed, 24 Jul 2019 15:30:54 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     davidc502 <davidc502@tds.net>, linux-block@vger.kernel.org,
        ilnux-nvme@lists.infradead.org
Subject: Re: fstrim error - AORUS NVMe Gen4 SSD
Message-ID: <20190724213054.GA5921@localhost.localdomain>
References: <fb510e33-5c81-6d62-fcde-a2989b3a1a8f@tds.net>
 <20190723021928.GF30776@ming.t460p>
 <4a7ec7aa-f6ee-f9dc-4a17-38f2b169c721@tds.net>
 <20190723043803.GB13829@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723043803.GB13829@ming.t460p>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 23, 2019 at 12:38:04PM +0800, Ming Lei wrote:
> From the IO trace, discard command(nvme_cmd_dsm) is failed:
> 
>   kworker/15:1H-462   [015] .... 91814.342452: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=7, cmdid=552, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_dsm nr=0, attributes=4)
>           <idle>-0     [013] d.h. 91814.342708: nvme_complete_rq: nvme0: disk=nvme0n1, qid=7, cmdid=552, res=0, retries=0, flags=0x0, status=8198
> 
> And the returned error code is 0x8198, I am not sure how to parse the
> 'Command Specific Status Values' of 0x98, maybe Christoph, Keith or our other
> NVMe guys can help to understand the failure.

The 198h status code is still marked reserved in the latest spec for an
NVM command set, so not sure what to make of it. I think we would have
to refer back to the vendor.

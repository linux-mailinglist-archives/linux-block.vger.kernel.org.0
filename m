Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B099C8DDC8
	for <lists+linux-block@lfdr.de>; Wed, 14 Aug 2019 21:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbfHNTK3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 14 Aug 2019 15:10:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:34832 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbfHNTK3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Aug 2019 15:10:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 12:10:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,386,1559545200"; 
   d="scan'208";a="352008658"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga005.jf.intel.com with ESMTP; 14 Aug 2019 12:10:27 -0700
Date:   Wed, 14 Aug 2019 13:08:15 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jay.vosburgh@canonical.com" <jay.vosburgh@canonical.com>,
        Dan Streetman <dan.streetman@canonical.com>
Subject: Re: [PATCH] nvme: Use first ctrl->instance id as subsystem id
Message-ID: <20190814190814.GC3256@localhost.localdomain>
References: <20190814142836.2322-1-gpiccoli@canonical.com>
 <20190814160640.GA3256@localhost.localdomain>
 <abfc4bd0-f4f0-5655-81ee-ec32d3516f35@canonical.com>
 <20190814162754.GB3256@localhost.localdomain>
 <b5b471cc-8935-cf96-d55a-a7dc731cb0d6@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5b471cc-8935-cf96-d55a-a7dc731cb0d6@canonical.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 14, 2019 at 11:29:17AM -0700, Guilherme G. Piccoli wrote:
> It is a suggestion from my colleague Dan (CCed here), something like:
> for non-multipath nvme, keep nvmeC and nvmeCnN (C=controller ida,
> N=namespace); for multipath nvme, use nvmeScCnN (S=subsystem ida).

This will inevitably lead to collisions. The existing naming scheme was
selected specifically to avoid that problem.

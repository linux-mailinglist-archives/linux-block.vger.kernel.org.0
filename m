Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7ED08D814
	for <lists+linux-block@lfdr.de>; Wed, 14 Aug 2019 18:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfHNQaJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 14 Aug 2019 12:30:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:40716 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfHNQaJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Aug 2019 12:30:09 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 09:30:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,385,1559545200"; 
   d="scan'208";a="260554007"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga001.jf.intel.com with ESMTP; 14 Aug 2019 09:30:07 -0700
Date:   Wed, 14 Aug 2019 10:27:54 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jay.vosburgh@canonical.com" <jay.vosburgh@canonical.com>
Subject: Re: [PATCH] nvme: Use first ctrl->instance id as subsystem id
Message-ID: <20190814162754.GB3256@localhost.localdomain>
References: <20190814142836.2322-1-gpiccoli@canonical.com>
 <20190814160640.GA3256@localhost.localdomain>
 <abfc4bd0-f4f0-5655-81ee-ec32d3516f35@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abfc4bd0-f4f0-5655-81ee-ec32d3516f35@canonical.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 14, 2019 at 09:18:22AM -0700, Guilherme G. Piccoli wrote:
> On 14/08/2019 13:06, Keith Busch wrote:
> > On Wed, Aug 14, 2019 at 07:28:36AM -0700, Guilherme G. Piccoli wrote:
> >>[...]
> > 
> > The subsystem lifetime is not tied to a single controller's. Disconnect
> > the "first" controller in a multipathed subsystem with this patch, then
> > connect another controller from a different subsystem, and now you will
> > create naming collisions.
> > 
> 
> Hi Keith, thanks for your clarification. Isn't the controller id unique?
> Could the new connected controller from a different subsystem have the
> same id? If you can give a rough example I appreciate.

Sure, start with nvme subsystem A, with host connected to to
controllers, X and Y.

 ctrl X gets instance 0, which you assign to the newly discovered
 subsytem

 ctrl Y gets instance 1

 disconnect ctrl X, which releases instance 0 back to the allocator

 connect to a new ctrl Z in new subsystem B: ctrl Z gets the first
 available instance, which is now 0, and you assign that name to the new
 susbystem, colliding with the sysfs nvme-subsys entries we've created
 for subsys A, as well as any namespaces.
 
> But given the above statement is a fact, what do you think of trying the
> ctrl->instance first and in case we have duplicity, fallback to
> subsystem ID allocator?

At the point we assign the subsystem identifier, we're locked into using
that for the namespace names, which may be discovered long before we're
aware the host has multiple connections to the same subsystem.

I think it'd be better to just completely disassociate any notion of
relationships based on names. The following patch enforces that way of
thinking:

  http://lists.infradead.org/pipermail/linux-nvme/2019-May/024142.html

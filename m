Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2CB27F73
	for <lists+linux-block@lfdr.de>; Thu, 23 May 2019 16:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbfEWOYL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 23 May 2019 10:24:11 -0400
Received: from mga12.intel.com ([192.55.52.136]:50864 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730709AbfEWOYK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 May 2019 10:24:10 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 May 2019 07:24:10 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga008.fm.intel.com with ESMTP; 23 May 2019 07:24:09 -0700
Date:   Thu, 23 May 2019 08:19:08 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <keith.busch@gmail.com>,
        Ming Lei <ming.lei@redhat.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/2] Reset timeout for paused hardware
Message-ID: <20190523141908.GA14943@localhost.localdomain>
References: <20190522174812.5597-1-keith.busch@intel.com>
 <20190523032925.GA10601@ming.t460p>
 <CAOSXXT45jyLrKZ56QOPGWFyajtSvgPQcT+f2nj95n9Eowb44FA@mail.gmail.com>
 <20190523101311.GB15492@lst.de>
 <20190523132304.GB14049@localhost.localdomain>
 <20190523141054.GA19635@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523141054.GA19635@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 23, 2019 at 04:10:54PM +0200, Christoph Hellwig wrote:
> On Thu, May 23, 2019 at 07:23:04AM -0600, Keith Busch wrote:
> > > Figure 49: Asynchronous Event Information - Notice
> > > 
> > > 1h		Firmware Activation Starting: The controller is starting
> > > 		a firmware activation process during which command
> > > 		processing is paused. Host software may use CSTS.PP to
> > > 		determine when command processing has resumed. To clear
> > > 		this event, host software reads the Firmware Slot
> > > 		Information log page.
> > > 
> > > So we are supposed to get an AEN before the device stops processing
> > > commands.
> > 
> > Hm, I read the same section, but conclude differently (and at least some
> > vendors did too). A spec compliant controller activating new firmware
> > without reset would stop processing commands and set CSTS.PP first,
> > then send the AEN. When the host is aware to poll Processing Paused,
> > the controller hasn't been processing new commands for some time.
> > 
> > Could you give some more detail on your interpretation?
> 
> What would be the point of the AEN if it wasn't sent at exactly
> the point when the controller stops acceppting command?
> 
> The wording is of course NVMe-like, but "The controller is starting a.."
> pretty clear implies this is sent at the beginning of the paused
> state, not the end.

Right, the controller starts the pause at time T1, and sends the AEN at
the same time. No new commands will be processed after T1 until the
firmware activate completes.

The host sees the AEN a short time later, time T2.

The time between T1 - T2, we may have sent many commands that are not
going to be processed, and we couldn't have known that when they were
submitted. The controller still owns those commands, and we just need
to adjust their deadlines once processing resumes.

Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA1D63F7A7
	for <lists+linux-block@lfdr.de>; Thu,  1 Dec 2022 19:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiLASn0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 1 Dec 2022 13:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiLASnZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Dec 2022 13:43:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293C9934C2;
        Thu,  1 Dec 2022 10:43:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC797620B3;
        Thu,  1 Dec 2022 18:43:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208F8C433D6;
        Thu,  1 Dec 2022 18:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669920204;
        bh=p4GYPrcLemfL1H4zQdK4YSafqKxYl8uzcCcsuNR5Mug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a2BoPen065qBe8Og5canw6L1zfhJNTp7AhJG9KCJ6kiqz0PbaFOGVhFTqYEHLQC/3
         txrNOo/kDMMWMmzGqvPwfOzgrz6vwm2Q1DicWoYbq+xwADN5A7BOVkCSHc8BU+fkbm
         ahiTJmpUWGq4d9z7eAd6F7xiHvrsPEH9AaFENflI=
Date:   Thu, 1 Dec 2022 19:43:20 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Wolfram Sang <wsa@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Ming Lei <ming.lei@redhat.com>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Won Chung <wonchung@google.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-block@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-i3c@lists.infradead.org, linux-input@vger.kernel.org,
        linux-media@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 3/5] driver core: make struct device_type.uevent() take a
 const *
Message-ID: <Y4j1yPD4Ypze7jx5@kroah.com>
References: <Y34hgIW8p1RlQTBB@smile.fi.intel.com>
 <97be39ed-3cea-d55a-caa6-c2652baef399@gmail.com>
 <Y34zyzdbRUdyOSkA@casper.infradead.org>
 <Y34+V2bCDdqujBDk@kroah.com>
 <Y35JfNJDppRp5bLX@ziepe.ca>
 <Y35R+/eQJYI7VaDS@kroah.com>
 <Y35YlI93UBuTfgYy@ziepe.ca>
 <Y35dMIaNYSE0Cykd@casper.infradead.org>
 <Y35enjI+dhhqiG3B@ziepe.ca>
 <Y35ftyYlE8FX8xQO@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y35ftyYlE8FX8xQO@casper.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 23, 2022 at 06:00:23PM +0000, Matthew Wilcox wrote:
> On Wed, Nov 23, 2022 at 01:55:42PM -0400, Jason Gunthorpe wrote:
> > On Wed, Nov 23, 2022 at 05:49:36PM +0000, Matthew Wilcox wrote:
> > > On Wed, Nov 23, 2022 at 01:29:56PM -0400, Jason Gunthorpe wrote:
> > > > #define generic_container_of(in_type, in, out_type, out_member) \
> > > > 	_Generic(in,                                        \
> > > >                   const in_type *: ((const out_type *)container_of(in, out_type, out_member)),   \
> > > >                   in_type *: ((out_type *)container_of(in, out_type, out_member)) \
> > > > 		  )
> > > 
> > > There's a neat trick I found in seqlock.h:
> > > 
> > > #define generic_container_of(in_t, in, out_t, m)			\
> > > 	_Generic(*(in),							\
> > > 		const in_t: ((const out_t *)container_of(in, out_t, m)), \
> > > 		in_t: ((out_t *)container_of(in, out_type, m))	\
> > > 	)
> > >
> > > and now it fits in 80 columns ;-)
> > 
> > Aside from less letters, is their another benifit to using *(in) ?
> 
> I don't think so.  It just looks nicer to me than putting the star in
> each case.  If I'd thought of it, I would have done it to page_folio(),
> but I won't change it now.

Ah, but your trick will not work, that blows up and will not build.  The
original one from Jason here does work.  _Generic is tricky...

thanks,

greg k-h

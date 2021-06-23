Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A2D3B1F58
	for <lists+linux-block@lfdr.de>; Wed, 23 Jun 2021 19:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhFWR0Y (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 23 Jun 2021 13:26:24 -0400
Received: from mail-pj1-f49.google.com ([209.85.216.49]:39461 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWR0W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jun 2021 13:26:22 -0400
Received: by mail-pj1-f49.google.com with SMTP id c7-20020a17090ad907b029016faeeab0ccso4239016pjv.4;
        Wed, 23 Jun 2021 10:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qholSjh3ojarhaiJVbkzlpDv++ltFn4VIcY+K7Wa0Kw=;
        b=pP1im9k5+kiiXxbiJRsjr2y3C4F0qI/wwjXXyb9Y0cdx0kwrd1r+Hut14kBaPKrEoU
         fZy360nktxMDkXo7ohMS+x9dsfB11QPwJ6LqjAQ/8tMtU9nTCYQjWtNUXaM/RuR8v5rv
         PwSNFAM3F1JJYKs9TSII913XqxK4W8sAR6l4ZX/k+P5YKjdAOc6Df5DXxQk8DqOWBtR9
         JIhJcUiiuuFhNFSmvnidgqfJqnDX1RQu+fnLQZT12Xj6SFUot9Qt6RyCpatJI46o2IG1
         L14n/g+Cwxekp8v131PL3m9C/hKWxD+1XdPt2+tyMeXNbY1yameLWCQbRoKiZ0O0GbA/
         OfHg==
X-Gm-Message-State: AOAM532LcegY0XVFDiQr1v52MN66Pz5jPsAo+ElOMyWJnQgRGT8u6how
        BjXRDR4RsNI/xPdoT6wmT6U=
X-Google-Smtp-Source: ABdhPJyl+7uYwONS8G/QSLwLHZE9CQr9QGzxB2iBrd40gNnm/Pd5JfxcUr3+RpNktTmlyLkxHdzLEQ==
X-Received: by 2002:a17:90b:11ca:: with SMTP id gv10mr10607517pjb.94.1624469043713;
        Wed, 23 Jun 2021 10:24:03 -0700 (PDT)
Received: from garbanzo ([191.96.121.71])
        by smtp.gmail.com with ESMTPSA id s22sm437457pfg.197.2021.06.23.10.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 10:24:02 -0700 (PDT)
Date:   Wed, 23 Jun 2021 10:23:59 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, minchan@kernel.org,
        axboe@kernel.dk, mbenes@suse.com, jpoimboe@redhat.com,
        tglx@linutronix.de, keescook@chromium.org, jikos@kernel.org,
        rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drivers/base/core: refcount kobject and bus on device
 attribute read / store
Message-ID: <20210623172359.4qlvkqtcmahs2qz5@garbanzo>
References: <20210623003630.274804-1-mcgrof@kernel.org>
 <YNLxtbzOm3/whYHc@kroah.com>
 <20210623161434.qraapo4xaprte7bs@garbanzo>
 <YNNmnrjpOGGVXsP2@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNNmnrjpOGGVXsP2@kroah.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 23, 2021 at 06:51:42PM +0200, Greg KH wrote:
> On Wed, Jun 23, 2021 at 09:14:34AM -0700, Luis Chamberlain wrote:
> > sysfs isn't doing any active reference check for the kobject device
> > attribute as it doesn't care for them. So syfs calls
> > dev_attr_store(), but the dev_attr_store() is not preventing the device
> > attribute ops to go fishing, and we destroy them while we're destroying
> > the device on module removal.
> 
> Ah, but sysfs _should_ be doing this properly.
> 
> I think the issue is that when we store the kobject pointer in kernfs,
> it is NOT incremented.  Look at sysfs_create_dir_ns(), if we call
> kobject_get(kobj) right before we call kernfs_create_dir_ns(), and then
> properly clean things up later on when we remove the sysfs directory
> (i.e. the kobject), it _should_ fix this problem.
> 
> Then, we know, whenever show/store/whatever is called, when we cast out
> of kernfs the private pointer to a kobject, that the kobject really is
> still alive, so we can use it properly.
> 
> Can you try that, it should be a much "simpler" change here.

Agreed, its cleaner. It should also address the type race consideration
I had, given that in the zram case, for instance, we will call device_del() on
del_gendisk() and the order of freeing typically is something like:

	del_gendisk(zram->disk);
	blk_cleanup_queue(zram->disk->queue);
	put_disk(zram->disk);

The put_disk() is what would make our gendisk->private_data invalid.
Will spin up a v4 with your suggestion.

  Luis

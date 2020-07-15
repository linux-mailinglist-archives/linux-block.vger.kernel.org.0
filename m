Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667192210A8
	for <lists+linux-block@lfdr.de>; Wed, 15 Jul 2020 17:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgGOPOQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 15 Jul 2020 11:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgGOPOQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jul 2020 11:14:16 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E47C061755
        for <linux-block@vger.kernel.org>; Wed, 15 Jul 2020 08:14:16 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k23so2583965iom.10
        for <linux-block@vger.kernel.org>; Wed, 15 Jul 2020 08:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nqN/nlAnHTnRrfA33dch8uc/t4YEiRlpuzW9f+rcyy0=;
        b=XKt7rlf59KxUX6pTMvbvxSd3bzafdmoCjiEJZ5+NqUw7xQJ+R5n8Xilxc2xjayoZZd
         e38niNvnhl8UHFLl/rOWkPU2MlG3d6I5QE4ii2JiS8a550TcDH/vj/gs0t47l7VVwtSC
         dYzMT0RpBJ9deDmHpmJnkPOIm+SPIuITGWslxEs0ntLLalXVMncue+6nlo10GG1TBafD
         09GjS6WIfRUeWAUrB1lQfVKqfIbQBybuVf+ERceHW6Up57Rlo8/3QVvzo/F/f9atbFTw
         o/rS0uydLdJEC6oFJAl9L3jf4hi2EfHdAPmSEpYFShkHf//xYDRjBO4dqCrofuH24Z27
         Yl/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nqN/nlAnHTnRrfA33dch8uc/t4YEiRlpuzW9f+rcyy0=;
        b=EkGxtEK3gjOJjl23Gbu7YUvx9PFFwDeR8vNwEY8O7zvlxXVh0GxFizuw+9Bx5JLPEm
         5ini0F2f6OfVg+0MyNfs3SQ6JtwY/cOT1BrXI3wh5M+w8FdX+slI6ke6I8Qrcjs0Sxye
         DD2gbZj3MZAZhlLKcdofsXCYv0eowRRiZqjnYpd8O/Or0H8u4WQuXepGZeKS0tzbn0sh
         x4zBWMdUvbouo3493H2AU1T3gqqpsDS6dans/Xo+VW7pfaDhOQb0hcxRtB0kK6oNA6c0
         BNRMlSeekDR/womxOwqe+1yYeu6DhcLWKDn4Z08P4UM5W/CGxyrlDAZwrnQDHtleGMpV
         OiXA==
X-Gm-Message-State: AOAM530OXoIb1IcSIAb7VkPWaXOmzcVQ1F1iu9FZpd+BM+tKSXb6NmVJ
        LBGm6KWOU4m6rXu+a88o7Hpl3wW3c5NhjA==
X-Google-Smtp-Source: ABdhPJwJXI8dGyjvEo5S560AUqFTPCum6B2sWgLxTOV+AnHD1lH1DKBYeYigBj/O9tJH6V5OucKX1A==
X-Received: by 2002:a05:6602:5db:: with SMTP id w27mr10741397iox.58.1594826055028;
        Wed, 15 Jul 2020 08:14:15 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s10sm1230869ilh.4.2020.07.15.08.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 08:14:14 -0700 (PDT)
Subject: Re: [PATCH] block: always remove partitions from
 blk_drop_partitions()
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20200715083619.624249-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <81cb2ba5-49d6-2842-8673-f5fd8fffd07a@kernel.dk>
Date:   Wed, 15 Jul 2020 09:14:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200715083619.624249-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/15/20 2:36 AM, Ming Lei wrote:
> In theory, when GENHD_FL_NO_PART_SCAN is set, no partitions can be created
> on one disk. However, ioctl(BLKPG, BLKPG_ADD_PARTITION) doesn't check
> GENHD_FL_NO_PART_SCAN, so partitions still can be added even though
> GENHD_FL_NO_PART_SCAN is set.
> 
> So far blk_drop_partitions() only removes partitions when disk_part_scan_enabled()
> return true. This way can make ghost partition on loop device after changing/clearing
> FD in case that PARTSCAN is disabled, such as partitions can be added
> via 'parted' on loop disk even though GENHD_FL_NO_PART_SCAN is set.
> 
> Fix this issue by always removing partitions in blk_drop_partitions(), and
> this way is correct because the current code supposes that no partitions
> can be added in case of GENHD_FL_NO_PART_SCAN.

Applied, thanks.

-- 
Jens Axboe


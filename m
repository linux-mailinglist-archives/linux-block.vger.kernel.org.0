Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3289919B718
	for <lists+linux-block@lfdr.de>; Wed,  1 Apr 2020 22:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732537AbgDAUfz (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 1 Apr 2020 16:35:55 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41103 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732337AbgDAUfz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Apr 2020 16:35:55 -0400
Received: by mail-qk1-f194.google.com with SMTP id q188so1535818qke.8;
        Wed, 01 Apr 2020 13:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0lGrPvexvbIcjwodeNp9Jn6H21gUFw8RbboRfmI5YEA=;
        b=e2tHQ5uvUcMCZsVSLUqlEwZtsU+LsYUWcM0gFVIoF5KGg+vxD0lUK+V+8NAbbQndUB
         L7HP5OdCyhdJ/AXVqPShbwsELihcK14zZHKQ8XGTYk+1k+f6/DRgm8EBRzVY8bHJeRN7
         3GzUf9nrm5dqIuzMZZi6NJYP1Xf88xu0FyIVPWseygbXW0Zc6AeolZRcAUAVFZCdWI8k
         RlNxDGOuqyKM8hJA6se5puMZoUCBkmThmGyqbIizVI5w2dy2mSMuaqZu2hCaGrgu4O+5
         ptE2Eqop7UTOuC90rFhAvq7JoelgboRTifLkhSoLUMXjR24zKRI0Vgjrj0AkJFAbmTyW
         T3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=0lGrPvexvbIcjwodeNp9Jn6H21gUFw8RbboRfmI5YEA=;
        b=mB6+mvmAS/oU+JajdmEJzZ1/tn0grIwGOeLbPEcebSjP9VQR5NCMSugDu4qIjpCDrK
         KtL8JVmtJ5rYWUaiMA4J3fwDvVWnxdFSAnRQnojlFZUhkeemp/RtC2aYLVPIQKd9Se7/
         sFaVC+QannAYetM+71eaogeqsID+dKY2JM5YQw6qnuhsM655QHYIFGhz3Z+zaQQpATGE
         h7UbP0hHcq89+FU6ibx7YXbau9D4vqpGgx9Kx4FXkm6aWHImWT7kjCEpPL1sDOnLhM2J
         IK9NaYdESKLtx6dXewWoEaz63x5b4Un0kuzrWcU823ZucMKp4jWDLB6P6CGrBe91wyC8
         w65w==
X-Gm-Message-State: AGi0PuYoSvGkr9mo3t5UmYwRgAeR4bmrlUykLYaPf/80gm35w5IjxXhy
        0ta0Q4AtveKMXgYg+wgh5Uw=
X-Google-Smtp-Source: APiQypI5J+wwK2P5GMhbFC6Z+ZRgIYib9jJYZWPn2AKkufm/ALocH/wD5W0oaiJLIy/0MVXyBi5j1w==
X-Received: by 2002:a05:620a:e:: with SMTP id j14mr162480qki.100.1585773353587;
        Wed, 01 Apr 2020 13:35:53 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::f621])
        by smtp.gmail.com with ESMTPSA id i186sm2156279qke.5.2020.04.01.13.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 13:35:52 -0700 (PDT)
Date:   Wed, 1 Apr 2020 16:35:51 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 2/2] blkcg: don't offline parent blkcg first
Message-ID: <20200401203551.GV162390@mtj.duckdns.org>
References: <20190724173517.GA559934@devbig004.ftw2.facebook.com>
 <20190724173722.GA569612@devbig004.ftw2.facebook.com>
 <20190724173755.GB569612@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724173755.GB569612@devbig004.ftw2.facebook.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 24, 2019 at 10:37:55AM -0700, Tejun Heo wrote:
> blkcg->cgwb_refcnt is used to delay blkcg offlining so that blkgs
> don't get offlined while there are active cgwbs on them.  However, it
> ends up making offlining unordered sometimes causing parents to be
> offlined before children.
> 
> Let's fix this by making child blkcgs pin the parents' online states.
> 
> Note that pin/unpin names are chosen over get/put intentionally
> because css uses get/put online for something different.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Jens, these two patches slipped through the cracks. Can you please take a look
at them?

Thanks.

-- 
tejun
